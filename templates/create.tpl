/*
 * Copyright 2022 The Go Authors<36625090@qq.com>. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 */

package {{.moduleName}}

import (
	"context"
	"github.com/36625090/turbo/logical"
)

//create 添加方法
func (b *backend) create(ctx context.Context, args *logical.Args, reply *logical.Reply) *logical.Error {
	var req CreateArgs
	if err := args.ShouldBindJSON(&req); err != nil {
		return err
	}

	return nil
}
