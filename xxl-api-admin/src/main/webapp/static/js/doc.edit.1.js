/**
 * 文档编辑
 */
$(function() {
	// ajax请求获取文档markdown
	$.get(base_url + "/gt-document/getDocMd", {
		"docId" : $("input[name='docId']").val()
	},
	function(data) {
		$("input[name='docTitle']").val(data.gtDoc.docTitle);
		var remarkEditor = editormd("docMd", {
			width : "100%",
			height : 500,
			syncScrolling : "single",
			path : base_url + "/static/plugins/editor.md-1.5.0/lib/",
			autoFocus : false,
			markdown : data.gtDoc.docContent,
			toolbarIcons : function() {
				// Or return editormd.toolbarModes[name]; // full, simple, mini
				//return editormd.toolbarModes['simple'];
				// Using "||" set icons align right.
				return [ "undo", "redo", "save", "|", "bold", "hr", "|",
						"watch", "fullscreen", "preview", "info" ]
			},
			toolbarIconsClass : {
				save : "fa-save" // 指定一个FontAawsome的图标类
			},
			toolbarHandlers : {
				save : function(cm, iconJquery, cursor, selection) {
					var docMd = remarkEditor.getMarkdown();
					var docParam = $("#docEditForm").serialize();
					docParam += '&' + $.param({
						"docMd" : docMd
					});
					// ajax请求保存数据
					$.ajax({
						url : base_url + "/gt-document/saveDocMd",
						type : "post",
						data : docParam,
						success : function(resData) {
							//document.location = base_url + "";
							// 填充docId
							console.log(resData);
							$("input[name='docId']").val(resData.docId);
						}
					});
				}
			},
			//图标文本提示
			lang : {
				toolbar : {
					save : "保存",
				}
			},
			placeholder : "请输入文档"
		});
	});

	// 表单验证
	$("#docEditForm").validate({
		rules : {
			docTitle : {
				required : true,
				rangelength : [ 5, 50 ]
			}
		},
		messages : {
			docTitle : {
				required : "请输入文档标题",
				rangelength : "文档标题长度必须是2到50个字符"
			}
		}
	});

});