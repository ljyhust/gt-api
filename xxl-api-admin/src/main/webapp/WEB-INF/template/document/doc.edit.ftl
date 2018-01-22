<!DOCTYPE html>
<html>
<head>
    <title>API管理平台</title>
    <#import "/common/common.macro.ftl" as netCommon>
    <@netCommon.commonStyle />
    <!-- DataTables -->
    <link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.css">

</head>
<body class="hold-transition skin-blue sidebar-mini <#if cookieMap?exists && "off" == cookieMap["adminlte_settings"].value >sidebar-collapse</#if>">
<div class="wrapper">
    <!-- header -->
    <@netCommon.commonHeader />
    <!-- left -->
    <@netCommon.commonLeft "projectList" />

    <!-- Content Wrapper. Contains page content -->
    <div class="content-wrapper">
        <!-- Content Header (Page header) -->
        <section class="content-header">
            <h1>文档管理<small>API管理平台</small></h1>
        </section>

        <section class="content">
            <div class="row">
                <!-- 文档目录，根据项目分文档，点击一下右边就展示文档内容 -->
                <div class="col-md-3">
                    <a class="btn btn-primary btn-block margin-bottom">${project.name}</a>
                    <div class="box box-solid">
                        <div class="box-header with-border">
                            <h3 class="box-title">文档目录</h3>

                            <div class="box-tools">
                                <button type="button" class="btn btn-box-tool" id="addDoc" ><i class="fa fa-plus"></i></button>
                            </div>

                        </div>
                        <div class="box-body no-padding">
                            <ul class="nav nav-pills nav-stacked">
                                <!-- 
                                <li <#if groupId == -1>class="active"</#if> groupId="-1" >
                                    <a href="${request.contextPath}/gt-document?productId=${productId}&groupId=-1" >
                                        <i class="fa fa-inbox"></i>全部
                                 -->
                                        <#--<span class="label label-primary pull-right">12</span>-->
                                <!-- 
                                    </a>
                                </li>
                                <li <#if groupId == 0>class="active"</#if> groupId="0" >
                                    <a href="${request.contextPath}/group?productId=${productId}&groupId=0" >
                                        <i class="fa fa-inbox"></i>默认分组
                                 -->
                                        <#--<span class="label label-primary pull-right">12</span>-->
                                 <!-- 
                                    </a>
                                </li>
                                 -->
                                <#if docCatalogList?exists && docCatalogList?size gt 0>
                                    <#list docCatalogList as docCatalog>
                                        <li <#if docCatalogId == docCatalog.id >class="active"</#if> docCatalogId="${docCatalog.id}" >
                                            <a href="${request.contextPath}/gt-document/docEdit?productId=${productId}&docCatalogId=${docCatalog.id}" >
                                                <i class="fa fa-inbox"></i>${docCatalog.docTitle}
                                                <#--<span class="label label-primary pull-right">12</span>-->
                                            </a>
                                        </li>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                        <!-- /.box-body -->
                    </div>

                </div>
                <!-- /.col -->
                
                <#--文档内容-->
                <div class="col-md-9">
                    <div class="box box-primary">
                        <#--标题栏-->
                        <div class="box-header with-border">
                            <h3 class="box-title">
                                <#if groupId==-1>全部
                                <#elseif groupId==0>默认分组
                                <#else>
                                    <#if groupInfo?exists>${groupInfo.name}</#if>
                                </#if>
                            </h3>

                            <#if groupInfo?exists>
                                &nbsp;&nbsp;
                                <button class="btn btn-warning btn-xs" type="button" id="updateGroup" >编辑分组</button>
                                <button class="btn btn-danger btn-xs" type="button" id="deleteGroup" _id="${groupInfo.id}" _productId="${groupInfo.productId}" >删除分组</button>
                                |
                            </#if>
                            
                            <button class="btn btn-info btn-xs" type="button" onclick="javascript:window.open('${request.contextPath}/document/addPage?productId=${productId}')" >+新增接口</button>
                            <!-- 发布接口 -->
                            <button class="btn btn-info btn-xs" type="button" id="pubApi">+发布接口</button>
                            &nbsp;&nbsp;
                            共<#if documentList?exists>${documentList?size}<#else>0</#if>个接口

                            <div class="box-tools pull-right">
                                <div class="has-feedback">
                                    <input type="text" class="form-control input-sm" id="searchUrl" placeholder="接口搜索">
                                    <span class="glyphicon glyphicon-search form-control-feedback"></span>
                                </div>
                            </div>
                        </div>

                        <div class="box-body no-padding">
                            <#--接口列表-->
                            <div class="table-responsive mailbox-messages">
                                <table class="table table-hover table-striped" id="documentList" >
                                    <thead>
                                        <tr>
                                            <th width="4%" ><i class="fa fa-star text-yellow"></i></th>
                                            <th width="25%" >接口名称</th>
                                            <th width="25%" >接口URL</th>
                                            <th width="15%" >分组</th>
                                            <th width="17%" >更新日期</th>
                                            <th width="7%" >操作</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <#if documentList?exists && documentList?size gt 0>
                                            <#list documentList as document>
                                                <tr requestUrl="${document.requestUrl}" >
                                                    <td class="mailbox-star">
                                                        <a href="#" class="markStar" _starLevel="${document.starLevel}" _id="${document.id}" >
                                                            <#if document.starLevel == 1><i class="fa fa-star text-yellow"></i>
                                                            <#else><i class="fa fa-star-o text-yellow"></i>
                                                            </#if>
                                                        </a>
                                                    </td>
                                                    <td class="mailbox-name" title="${document.name}" >
                                                        <#if document.status==0><i class="fa fa-circle-o text-green"></i>
                                                        <#elseif document.status==1><i class="fa fa-circle-o text-yellow"></i>
                                                        <#else><i class="fa fa-circle-o text-light-gray"></i></#if>
                                                        <a href="${request.contextPath}/document/detailPage?id=${document.id}" target="_blank" >
                                                            <#if document.name?length gt 12>${document.name?substring(0, 12)}<#else>${document.name}</#if>
                                                        </a>
                                                    </td>
                                                    <td class="mailbox-attachment" title="${document.requestUrl}" >
                                                        <span class="label label-success">${document.requestMethod}</span>&nbsp;&nbsp;<#if document.requestUrl?length gt 25>${document.requestUrl?substring(0, 25)}...<#else>${document.requestUrl}</#if>
                                                    </td>
                                                    <td class="mailbox-date">
                                                        <#if groupList?exists && groupList?size gt 0>
                                                            <#list groupList as group>
                                                                <#if group.id == document.groupId >${group.name}</#if>
                                                            </#list>
                                                        </#if>
                                                    </td>
                                                    <td class="mailbox-date">${document.updateTime?datetime}</td>
                                                    <td class="mailbox-date" >
                                                        <a href="${request.contextPath}/document/updatePage?id=${document.id}" target="_blank"  style="color:gray;" onmouseover="this.style.cssText='color:silver;'" onmouseout="this.style.cssText='color:gray;'" title="修改" ><i class="fa fa-fw fa-wrench"></i></a>
                                                        <a href="javascript:;" class="deleteDocument" _id="${document.id}" _name="${document.name}" style="color:gray;" onmouseover="this.style.cssText='color:silver;'" onmouseout="this.style.cssText='color:gray;'" title="删除" ><i class="fa fa-fw fa-trash-o"></i></a>
                                                    </td>
                                                </tr>
                                            </#list>
                                        </#if>
                                    </tbody>
                                </table>
                                <!-- /.table -->
                            </div>
                        </div>

                    </div>
                    <!-- /. box -->
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </section>
        <!-- /.content -->

    </div>

    <!-- footer -->
    <@netCommon.commonFooter />
</div>

<!-- 新增-文档.模态框 -->
<div class="modal fade" id="addGroupModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" >新增文档</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal form" role="form" >
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">文档名称<font color="red">*</font></label>
                        <div class="col-sm-10"><input type="text" class="form-control" name="name" placeholder="请文档“文档名称”" maxlength="32" ></div>
                    </div>
                    <!-- 
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">分组排序<font color="red">*</font></label>
                        <div class="col-sm-10"><input type="text" class="form-control" name="order" placeholder="请输入“分组排序”" maxlength="5" ></div>
                    </div>
                     -->
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                            <button type="submit" class="btn btn-primary"  >保存</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>

                            <input type="hidden" name="productId" value="${productId}" >
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 更新-分组.模态框 -->
<div class="modal fade" id="updateGroupModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" >更新接口分组</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal form" role="form" >
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">分组名称<font color="red">*</font></label>
                        <div class="col-sm-10"><input type="text" class="form-control" name="name" placeholder="请输入“分组名称”" maxlength="12" value="<#if groupInfo?exists>${groupInfo.name}</#if>" ></div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-2 control-label">分组排序<font color="red">*</font></label>
                        <div class="col-sm-10"><input type="text" class="form-control" name="order" placeholder="请输入“分组排序”" maxlength="5" value="<#if groupInfo?exists>${groupInfo.order}</#if>" ></div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                            <button type="submit" class="btn btn-primary"  >保存</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>

                            <input type="hidden" name="id" value="<#if groupInfo?exists>${groupInfo.id}</#if>" >
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 新增 发布指定接口.模态框 -->
<div class="modal fade" id="pubApiModal" tabindex="-1" role="dialog"  aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" >发布指定项目</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal form" role="form" >
                    <div class="form-group">
                        <label for="lastname" class="col-sm-4 control-label">接口分组</label>
                        
                        <div class="col-sm-8">
                            <!--
                            <select class="form-control" name="bizId" >
                                <option value="0" >默认</option>
                            <#if bizList?exists && bizList?size gt 0>
                                <#list bizList as biz>
                                    <option value="${biz.id}" >${biz.bizName}</option>
                                </#list>
                            </#if>
                            </select>
                             -->
                            <select class="form-control select2" style="width: 100%;" name="groupId">
                                <option value="0" <#if 0 == document.groupId>selected</#if> >默认分组</option>
                                <#if groupList?exists && groupList?size gt 0>
                                    <#list groupList as group>
                                        <option value="${group.id}" <#if group.id == document.groupId>selected</#if> >${group.name}</option>
                                    </#list>
                                </#if>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-4 control-label">接口名称<font color="red">*</font></label>
                        <div class="col-sm-8"><input type="text" class="form-control" name="apiName" placeholder="请输入“接口名称”" maxlength="200" ></div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-4 control-label">接口URL<font color="red">*</font></label>
                        <div class="col-sm-8"><input type="text" class="form-control" name="requestUrl" placeholder="请输入接口URL（相对地址）" maxlength="100" ></div>
                    </div>
                    <div class="form-group">
                        <label for="lastname" class="col-sm-4 control-label">请求方法<font color="red">*</font></label>
                        <div class="col-sm-8">
                            <select class="form-control select2" style="width: 100%;" name="requestMethod">
                                <#list RequestMethodEnum as item>
                                    <option value="${item}" <#if item == document.requestMethod>selected</#if> >${item}</option>
                                </#list>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                            <button type="submit" class="btn btn-primary"  >保存</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<@netCommon.commonScript />
<!-- DataTables -->
<script src="${request.contextPath}/static/plugins/jquery/jquery.validate.min.js"></script>
<!-- moment -->
<script src="${request.contextPath}/static/js/document.list.1.js"></script>
</body>
</html>
