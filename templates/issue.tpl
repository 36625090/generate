/*
 * Copyright 2022 The Go Authors<36625090@qq.com>. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 */

package {{.moduleName}}

import (
	"github.com/36625090/turbo/logical"
	"github.com/36625090/turbo/logical/codes"
)

func sqlIssue(message string) *logical.Error {
	return logical.NewError(codes.CodeSqlIssue).WithErrStr(message)
}
