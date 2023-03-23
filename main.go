//go:gen
/*
 * Copyright 2022 The Go Authors<36625090@qq.com>. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 */

package main

import (
	"bytes"
	"fmt"
	"generate/option"
	"io/fs"
	"log"
	"os"
	"path/filepath"
	"strings"
	"text/template"
)

func LoadTemplates(templatesDir string, operations ...string) map[string]*template.Template {
	funcs := template.FuncMap{"upperFirst": func(in string) string {
		return strings.ToUpper(fmt.Sprintf("%c", in[0])) + in[1:]
	}}

	templates := make(map[string]*template.Template)
	files := make(map[string]string)

	if err := filepath.Walk(templatesDir, func(path string, info fs.FileInfo, err error) error {
		ext := filepath.Ext(path)
		if ext != ".tpl" {
			return nil
		}
		name := strings.ReplaceAll(filepath.Base(path), ext, "")
		files[name] = path
		return nil
	}); err != nil {
		log.Fatal("[ERROR] walking templates dir: ", err)
		return nil
	}

	for name, path := range files {
		data, err := os.ReadFile(path)
		if err != nil {
			log.Fatal(err)
		}
		tpl, err := template.New(name).Funcs(funcs).Parse(string(data))
		if err != nil {
			log.Fatal(err)
		}
		templates[name] = tpl
	}
	return templates
}

func exists(name string) bool {
	if _, err := os.Stat(name); err == nil {
		return true
	}
	return false
}

func MapKeys(m map[string]*template.Template) []string {
	var keys []string
	for key, _ := range m {
		keys = append(keys, key)
	}
	return keys
}

func main() {
	opts, err := option.NewOptions()
	if err != nil {
		log.Fatal(err)
		return
	}

	data := map[string]string{
		"moduleName":  opts.Module,
		"description": opts.Description,
	}

	log.Println("[INFO] generating...")
	templates := LoadTemplates(opts.Templates)
	log.Println("[INFO] generate operators: ", MapKeys(templates))

	dir := filepath.Join(opts.Output, opts.Module)

	if !opts.Trial {
		os.MkdirAll(dir, os.ModePerm)
	}

	log.Println("[INFO] generate using path: ", dir)

	for name, tmp := range templates {
		var buf bytes.Buffer
		tmp.Execute(&buf, data)
		if name == "endpoint" {
			name = opts.Module
		} else if name == "params" {

		} else {
			name = opts.Module + "_" + name
		}

		filename := fmt.Sprintf("%s/%s.go", dir, name)

		if exists(filename) {
			log.Println("[WARN] file: ", filename, " exists")
		} else {
			if !opts.Trial {
				os.WriteFile(filename, buf.Bytes(), os.ModePerm)
			}
		}
	}

	log.Println("[INFO] generated!!!")
}
