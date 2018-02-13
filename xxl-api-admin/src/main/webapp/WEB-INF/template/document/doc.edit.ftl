<!DOCTYPE html>
<html>
<head>
    <title>API管理平台</title>
    <#import "/common/common.macro.ftl" as netCommon>
    <@netCommon.commonStyle />
    <!-- DataTables -->
    <link rel="stylesheet" href="${request.contextPath}/static/adminlte/plugins/datatables/dataTables.bootstrap.css">
	<link rel="stylesheet" href="${request.contextPath}/static/plugins/editor.md-1.5.0/main/editormd.min.css">
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
            <form class="form-horizontal" id="docEditForm">
                <div class="box box-primary">
                    <div class="box-body">
		                <div class="form-group" style="width:auto">
		                	<div class="col-sm-6">
		                    	<input type="text" class="form-control" name="docTitle" placeholder="请输入文档标题" maxlength="100" />
		                    </div>
		                    <font color="red" size="5px">*</font>
		                    	
		                </div>
                        <div class="box-body pad" id="docMd"></div>
                    </div>
                </div>
                <input type="hidden" name="projectId" value="${productId}"/>
        	</form>
        </section>
        <!-- /.content -->

    </div>

    <!-- footer -->
    <@netCommon.commonFooter />
</div>


<@netCommon.commonScript />
<!-- DataTables -->
<script src="${request.contextPath}/static/plugins/jquery/jquery.validate.min.js"></script>
<!-- moment -->
<script src="${request.contextPath}/static/plugins/editor.md-1.5.0/main/editormd.min.js"></script>
<script src="${request.contextPath}/static/js/doc.edit.1.js"></script>
</body>
</html>
