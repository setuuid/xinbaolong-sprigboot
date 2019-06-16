<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/common/includes.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>付款管理查询</title>
<%@ include file="/WEB-INF/jsp/common/common.jsp"%>
</head>
<body>
	<div id="context">
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="panel-group" id="accordion">
						<div class="panel panel-primary">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a id="example" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" style="display: block;">
										<span class="label label-primary">付款管理>>付款登记>>查询</span>
									</a>
								</h4>
							</div>
							<div id="collapseOne" class="panel-collapse collapse in">
								<div class="panel-body">
									<form:form name="payment" commandName="payment" id="payment" action="${ctx}/payment/query.do">
										<table id="queryTable" class="table table-condensed ">
											<tr>
												<th>付款流水号</th>
												<td><form:input path="paymentNo" id="paymentNo" maxlength="32" cssClass="form-control input-sm"/></td>
												<th>填报日期</th>
												<td>
													<div class="input-group">
														<form:input type="text" id="fillingStartDate" path="fillingStartDate" cssClass="form-control input-sm form_datetime" readonly="true"/>
														<span class="input-group-btn">
															<button class="btn btn-primary btn-sm" type="button" name="clearBegin">
																<span class="glyphicon glyphicon-remove"></span>
															</button>
														</span>
													</div>
													<div class="input-group">
														<form:input type="text" id="fillingEndDate" path="fillingEndDate" cssClass="form-control input-sm form_datetime" readonly="true"/>
														<span class="input-group-btn">
															<button class="btn btn-primary btn-sm" type="button" name="clearEnd">
																<span class="glyphicon glyphicon-remove"></span>
															</button>
														</span>
													</div>
												</td>
											</tr>
											<tr>
												<td colspan="6" id="tools">
													<input type="submit" value="查询" class="btn btn-primary btn-xs" />
													<input type="button" value="重置"  onclick="resetControl()" class="btn btn-primary btn-xs" />
												</td>
											</tr>
										</table>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="span12" style="margin-top: 10px;">
					<div class="panel-group" id="accordion2">
						<div class="panel panel-default">
							<div class="panel-heading">
								<a id="example2" data-toggle="collapse" data-parent="#accordion2" href="#collapseTwo"> 
									<span class="icon"><span class="glyphicon glyphicon-file"></span></span>
								</a>
								<security:authorize ifAllGranted="ROLE_PAYMENT_ADD">
								<a class="btn btn-primary btn-xs" href='${ctx}/payment/edit.do'>新建付款</a>
								</security:authorize>
							</div>
							<div id="collapseTwo" class="panel-collapse collapse in">
								<div class="panel-body">
									<table class="table table-striped table-condensed table-hover">
										<tr>
											<th>序号</th>
											<th>付款单号</th>
											<th>填报日期</th>
											<th>供应商</th>
											<th>状态</th>
											<th>操作</th>
										</tr>
										<c:forEach var="t" items="${payment.paymentList }" varStatus="c">
											<tr>
												<td>${c.count }</td>
												<td><a onclick="modal(900,600,'${ctx}/payment/view.do?id=${t.id}');">${t.paymentNo }</a></td>
												<td><fmt:formatDate value="${t.fillingDate }" pattern="yyyy-MM-dd" /></td>
												<td>${t.supplier_name}</td>
												<td>${t.state}</td>
												<td style="width:20%">
												<security:authorize ifAllGranted="ROLE_PAYMENT_MOD">
								                   <a class="btn btn-primary btn-xs"  href='${ctx}/payment/edit.do?id=${t.id }'><span class="glyphicon glyphicon-pencil"></span> 修改</a>
								                 </security:authorize>
												<c:if test="${t.state=='未付款'}">
													<security:authorize ifAllGranted="ROLE_PAYMENT_DELETE">
													  <button class="btn btn-primary btn-xs" onclick="deletepayment('${t.id }');"><span class="glyphicon glyphicon-trash"></span>删除</button>
													</security:authorize>
													<security:authorize ifAllGranted="ROLE_PAYMENT_STATE">
								                      <a class="btn btn-primary btn-xs"  href='${ctx}/payment/updateState.do?id=${t.id }'><span class="glyphicon glyphicon-pencil"></span> 付款</a>
								                    </security:authorize>
												</c:if>
												</td>
											</tr>
										</c:forEach>
									</table>
								</div>
								<!------------- 分页开始 ------------->
								<table class="table table-condensed" id="pageTools">
									<tr>
										<td>
											<jsp:include page="../../common/page.jsp">
												<jsp:param name="url" value="${pageUrl}" />
											</jsp:include>
										</td>
									</tr>
								</table>
								<!------------- 分页结束 ------------->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		<form id="condition" name="condition" hidden="true" method="post">
		<input type="text" id="paymentNo" name="paymentNo" value="${payment.paymentNo}" class="form-control input-sm" /> 
		<input type="text" id="fillingStartDate" name="fillingStartDate" value="${payment.fillingStartDate}" class="form-control input-sm" /> 
		<input type="text" id="out_date_end" name="fillingEndDate" value="${payment.fillingEndDate}" class="form-control input-sm" />
	</form>
 <script type="text/javascript">
    function resetControl(){
  	  $("#paymentNo").val("");
  	  $("#fillingStartDate").val("");
  	  $("#fillingEndDate").val("");
    }

 	function deletepayment(id){
		if(confirm("确定删除吗?")){	
			window.location.href='${ctx}/payment/delete.do?id='+id;
		}
	} 
 </script>
</body>
</html>