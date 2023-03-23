package option

import (
	"github.com/jessevdk/go-flags"
	"os"
	"syscall"
)

// Options 服务参数选项（OOPs 英语不好，注释描述凑合看，写中文怕终端乱码 ^ - ^）
type Options struct {
	Output      string   `short:"o" long:"output"  description:"Path for output"`
	Module      string   `short:"m" long:"module"  description:"Module name for service"`
	Description string   `short:"d" long:"description" description:" Profile for runtime"`
	Templates   string   `short:"t" long:"templates" default:"templates" description:"Path for templates"`
	Operators   []string `long:"operators" description:"Operators for file parse(default using template name)"`
	Trial       bool     `long:"trial" description:"Dry run, if provided"`
}

var opts Options
var parser *flags.Parser

func init() {
	parser = flags.NewParser(&opts, flags.Default)
}

func NewOptions() (*Options, error) {
	if _, err := parser.ParseArgs(os.Args[1:]); err != nil {
		os.Stdout.WriteString(err.Error())
		return nil, err
	}
	if opts.Module == "" {
		os.Stdout.WriteString("the required flag `--module' was not specified\n")
		syscall.Exit(0)
	}
	if opts.Description == "" {
		os.Stdout.WriteString("the required flag `--desc' was not specified\n")
		syscall.Exit(0)
	}

	return &opts, nil
}
