/*
 * Copyright 2022 The Go Authors<36625090@qq.com>. All rights reserved.
 * Use of this source code is governed by a MIT-style
 * license that can be found in the LICENSE file.
 */

package {{.moduleName}}

import (
	"github.com/36625090/turbo/framework"
	"github.com/36625090/turbo/logical"
    "github.com/36625090/turbo/logical/codes"
    "github.com/hashicorp/go-hclog"
	"reflect"
)

type backend struct {
	*framework.Backend
}

func NewEndpoint(b *framework.Backend) *framework.Endpoint {
	return (&backend{b}).endpoint()
}

func (b *backend) endpoint() *framework.Endpoint {
	return &framework.Endpoint{
		Pattern:     "{{.moduleName}}",
		Description: "{{.description}}",
		Operations: map[string]framework.OperationHandler{
			"list": &framework.EndpointOperation{
				Description: "列表",
				Callback:    b.list,
				LogLevel:    hclog.Info,
				Input:       reflect.TypeOf(ListArgs{}),
				Output:      reflect.TypeOf([]ListReply{}),
			},
			"create": &framework.EndpointOperation{
				Description: "创建",
				Callback:    b.create,
				Input:       reflect.TypeOf(CreateArgs{}),
				Output:      reflect.TypeOf(CreateReply{}),
			},
			"detail": &framework.EndpointOperation{
            	Description: "详情",
            	Callback:    b.detail,
            	Input:       reflect.TypeOf(DetailArgs{}),
            	Output:      reflect.TypeOf(DetailReply{}),
            },
            "update": &framework.EndpointOperation{
            	Description: "更新",
            	Callback:    b.update,
            	Input:       reflect.TypeOf(UpdateArgs{}),
            	Output:      reflect.TypeOf(UpdateReply{}),
            },
            "delete": &framework.EndpointOperation{
            	Description: "删除",
            	Callback:    b.delete,
            	Input:       reflect.TypeOf(DeleteArgs{}),
            	Output:      reflect.TypeOf(DeleteReply{}),
            },
		},
	}
}