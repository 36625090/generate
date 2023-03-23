/*
 * Copyright 2022 The Go Authors<36625090@qq.com>. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 */

package {{.moduleName}}

import (
	"context"
	"github.com/36625090/turbo/logical"
	"github.com/36625090/turbo/logical/codes"
	"github.com/36625090/xorm/pageable"
)

func (b *backend) list(ctx context.Context, args *logical.Args, reply *logical.Reply) *logical.Error {
	var req ListArgs
	if err := args.ShouldBindJSON(&req); nil != err {
		return err
	}
	page := pageable.NewPageable(req.Page, req.Size)
	var {{.moduleName}} []*models.{{upperFirst .moduleName}}
	filter := models.{{upperFirst .moduleName}}{

	}

	p, err := b.XormPlus.FindPagination(&{{.moduleName}}, page, &filter)
	if err != nil {
		return logical.NewError(codes.CodeSqlIssue).WithErr(err)
	}

	reply.Data = {{.moduleName}}
	reply.Pagination = &logical.Pagination{
		Page:       req.Page,
		Size:       req.Size,
		Total:      p.Total,
		TotalPages: p.TotalPages,
	}
	return nil
}
