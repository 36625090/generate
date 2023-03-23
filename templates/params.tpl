/*
 * Copyright 2022 The Go Authors<36625090@qq.com>. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 */

package {{.moduleName}}

type ListArgs struct {
	Page     int     `json:"page" validate:"required"`
	Size     int     `json:"size" validate:"required"`
}

type ListReply struct {
}

// CreateArgs 创建参数
type CreateArgs struct {
}
type CreateReply struct {
}

// UpdateArgs 更新参数
type UpdateArgs struct {
}
type UpdateReply struct {
}

// DetailArgs 详情参数
type DetailArgs struct {
}

// DetailReply 地址表
type DetailReply struct {
}

// DeleteArgs 删除参数
type DeleteArgs struct {
}
type DeleteReply struct {
}
