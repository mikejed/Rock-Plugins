DECLARE @p_CheckinPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = 'cdf2c599-d341-42fd-b7dc-cd402ea96050');
DECLARE @i_CheckoutChild AS INT = (SELECT TOP 1 [Order] FROM [Page] WHERE [ParentPageId]=@p_CheckinPageId ORDER BY [Order] DESC)+1;

DECLARE @p_SelfCheckoutPageGuid AS UNIQUEIDENTIFIER = '34dc70e8-58a8-43e3-b2ba-f4b2b656ebd6';
DECLARE @p_BulkCheckoutPageGuid AS UNIQUEIDENTIFIER = 'ec6fd761-f343-491a-90b1-c63370b12cc9';

DECLARE @l_FullWidthCheckoutLayout = (SELECT [Id] FROM [Layout] WHERE [Name]='Full Width' AND [SiteId] = (SELECT [Id] FROM [Site] WHERE [Guid]='15aefc01-acb3-4f5d-b83e-ab3ab7f2a54a'));

DECLARE @r_CheckoutPageRouteGuid AS UNIQUEIDENTIFIER = '21229c4b-41f0-4a71-ad61-4ddb7401cbda';

DECLARE @b_DynamicDataBlockTypeId AS INT = (SELECT [Id] FROM [BlockType] WHERE [Guid] = 'e31e02e9-73f6-4b3e-98ba-e0e4f86ca126'); --should be 143
DECLARE @b_HtmlBlockTypeId AS INT = (SELECT [Id] FROM [BlockType] WHERE [Guid] = '19b61d65-37e3-459f-a44f-def0089118a3'); --should be 6

DECLARE @b_SelfCheckoutUndoGuid AS UNIQUEIDENTIFIER = '0e8ca1d9-ff27-43e9-9817-3c8d0e52e640';
DECLARE @b_SelfCheckoutSqlGuid AS UNIQUEIDENTIFIER = '1248629e-039f-4263-8d23-c3f5a4f52859';
DECLARE @b_SelfCheckoutListGuid AS UNIQUEIDENTIFIER = '666d60e0-7a53-4eb2-b00c-1b9caceb11c7';
DECLARE @b_BulkCheckoutLinkGuid AS UNIQUEIDENTIFIER = '44b42068-25d4-4a24-ac8d-450ab1e20976';
DECLARE @b_BulkCheckoutSqlGuid AS UNIQUEIDENTIFIER = '23038704-d899-4567-8c24-1b4f791faabd';
DECLARE @b_BulkCheckoutListGuid AS UNIQUEIDENTIFIER = '7a4018fd-dd4c-4dcf-b8e1-8aef4fd0512d';
DECLARE @b_SelfCheckoutLinkGuid AS UNIQUEIDENTIFIER = '1ab07025-b0ee-4477-bd42-e2d0736d3391';
DECLARE @BlockId AS INT;

DECLARE @a_ddUpdatePageId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '230edfe8-33ca-478d-8c9a-572323af3466');
DECLARE @a_ddQueryParamsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = 'b0ec41b9-37c0-48fd-8e4e-37a8ca305012');
DECLARE @a_ddColumnsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '90b0e6af-b2f4-4397-953b-737a40d4023b');
DECLARE @a_ddQueryId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '71c8ba4e-8ef2-416b-bfe9-d1d88d9aa356');
DECLARE @a_ddUrlMaskId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = 'b9163a35-e09c-466d-8a2d-4ed81df0114c');
DECLARE @a_ddShowColumnsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '202a82bf-7772-481c-8419-600012607972');
DECLARE @a_ddMergeFieldsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '8eb882ce-5bb1-4844-9c28-10190903eecd');
DECLARE @a_ddFormattedOutputId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '6a233402-446c-47e9-94a5-6a247c29bc21');
DECLARE @a_ddPersonReportId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '8104ce53-fdb3-4e9f-b8e7-fd9e06e7551c');
DECLARE @a_ddStoredProcedureId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '7facab47-0e21-4436-921b-fee2d7d1be16');
DECLARE @a_ddShowCommunicateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = 'aab9f260-50fe-45da-840a-6025d0c66833');
DECLARE @a_ddShowMergePersonId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = 'a446bf83-2616-4af7-a77c-053fb7c49bbc');
DECLARE @a_ddShowBulkUpdateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '81404950-7b3f-4f52-9dec-b970a664f7e0');
DECLARE @a_ddShowExcelExportId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '925d4406-6908-47f3-b1da-12b3738c4299');
DECLARE @a_ddShowMergeTemplateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = 'fc6c462f-8e5f-4ab0-899b-9dd84c93313c');
DECLARE @a_ddPageTitleLavaId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = 'e7847eb6-280a-4206-a9cb-f7d6b7c3a99e');
DECLARE @a_ddShowGridFilterId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '1d72fdca-5e02-418c-8e5a-f49a64af48b3');
DECLARE @a_ddTimeoutId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '08e8a18c-02b3-49d0-80ce-21acc6284066');
DECLARE @a_ddPaneledGridId AS INT = (SELECT [Id] FROM [Attribute] WHERE [Guid] = '653994da-545e-4fba-86f6-3e0b6a217e10');

-- Create the self-checkout page
INSERT INTO [Page]
	([InternalName], [ParentPageId], [PageTitle], [IsSystem], [LayoutId], [EnableViewState], [PageDisplayTitle], [PageDisplayBreadCrumb], [PageDisplayIcon], [PageDisplayDescription], [DisplayInNavWhen], [MenuDisplayChildPages], [BreadCrumbDisplayName], [Order], [OutputCacheDuration], [IncludeAdminFooter], [Guid], [BrowserTitle])
	VALUES
	("Self Check-out", @p_CheckoutPageId, "Self Check-out", 0, @l_FullWidthCheckoutLayout, 1, 1, 1, 1, 1, 0, 1, 1, @i_CheckoutChild, 0, 1, @p_SelfCheckoutPageGuid, "Self Check-out");

-- Store the Page ID for the self-checkout page
DECLARE @p_SelfCheckoutPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_SelfCheckoutPageGuid);

-- Set the path for the self-checkout page
IF (SELECT count(*) FROM [PageRoute] WHERE [Route]='checkout') = 0
	INSERT INTO [PageRoute]
		([IsSystem], [PageId], [Route], [Guid])
		VALUES
		(0, @p_SelfCheckoutPageId, "checkout", @r_CheckoutPageRouteGuid);

-- Create the bulk checkout page
INSERT INTO [Page]
	([InternalName], [ParentPageId], [PageTitle], [IsSystem], [LayoutId], [EnableViewState], [PageDisplayTitle], [PageDisplayBreadCrumb], [PageDisplayIcon], [PageDisplayDescription], [DisplayInNavWhen], [MenuDisplayChildPages], [BreadCrumbDisplayName], [Order], [OutputCacheDuration], [IncludeAdminFooter], [Guid], [BrowserTitle])
	VALUES
	("Bulk Check-out", @p_CheckinPageId, "Bulk Check-out", 0, @l_FullWidthCheckoutLayout, 1, 1, 1, 1, 1, 0, 1, 1, @i_Checkoutchild, 0, 1, @p_BulkCheckoutPageGuid, "Bulk Check-out");

-- Store the Page ID for the bulk checkout page
DECLARE @p_BulkCheckoutPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_BulkCheckoutPageGuid);

-- Create blocks on self-checkout page
INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_SelfCheckoutPageId, @b_DynamicDataBlockTypeId, 'Main', 0, "Undo checkout", 0, @b_SelfCheckoutUndoGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_SelfCheckoutUndoGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, 'undocheckout=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'UPDATE [Attendance] SET [EndDateTime]=null WHERE [Id]=@undocheckout AND [EndDateTime] IS NOT NULL;', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPersonReportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddStoredProcedureId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowCommunicateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergePersonId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowBulkUpdateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowExcelExportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergeTemplateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPageTitleLavaId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowGridFilterId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddTimeoutId, @BlockId, '30', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPaneledGridId, @BlockId, 'False', NEWID());

INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_SelfCheckoutPageId, @b_DynamicDataBlockTypeId, 'Main', 1, "Checkout SQL", 0, @b_SelfCheckoutSqlGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_SelfCheckoutSqlGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, '@checkout=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'SELECT
	p.[NickName] + '' '' + p.[LastName] AS "Name"
FROM
	[Attendance] a
	LEFT JOIN [PersonAlias] pa ON a.[PersonAliasId]=pa.[Id]
	LEFT JOIN [Person] p ON pa.[PersonId] = p.[Id]
WHERE
	a.[Id]=@checkout
	AND a.[EndDateTime] IS NULL;
UPDATE [Attendance] SET [EndDateTime]=''{{ ''Now'' | Date:''yyyy'' }}-{{ ''Now'' | Date:''MM'' }}-{{ ''Now'' | Date:''dd'' }} {{ ''Now'' | Date:''hh'' }}:{{ ''Now'' | Date:''mm'' }}:{{ ''Now'' | Date:''ss'' }}'' WHERE [Id]=@checkout AND [EndDateTime] IS NULL;', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '{% for row in rows %}
	<div id="CheckoutConfirmation" class="alert alert-warning" style="position:fixed;top:0px;right:0px;left:0px;z-index:1000;">{{row.Name}} has been checked out.<a class="btn btn-default pull-right" style="margin-top:-7px;margin-bottom:-7px;" href="/checkout?undocheckout={{ PageParameter.checkout }}">Undo</a></div>
{% endfor %}
<script>
setTimeout(function() {
	$("#CheckoutConfirmation").fadeOut();
}, 5000);
</script>', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPersonReportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddStoredProcedureId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowCommunicateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergePersonId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowBulkUpdateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowExcelExportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergeTemplateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPageTitleLavaId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowGridFilterId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddTimeoutId, @BlockId, '30', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPaneledGridId, @BlockId, 'False', NEWID());

INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_SelfCheckoutPageId, @b_DynamicDataBlockTypeId, 'Main', 2, "Check-out list", 0, @b_SelfCheckoutListGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_SelfCheckoutListGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, '@checkout=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'SELECT
	p.[NickName] + ' ' + p.[LastName] AS "Name"
	,a.[StartDateTime]
	,a.[Id] AS "CheckOutId"
FROM
	[Attendance] a
	LEFT JOIN [PersonAlias] pa ON a.[PersonAliasId]=pa.[Id]
	LEFT JOIN [Person] p ON pa.[PersonId] = p.[Id]
WHERE
	a.[ScheduleId] IS NOT NULL
	AND a.[StartDateTime] > ''{{ "Now" | Date:"yyyy-M-d" }}''
	AND a.[EndDateTime] IS NULL
	AND a.[Id] <> @checkout', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '<div class="checkin-header">
	<h1>Self check-out</h1>
</div>
Select your name to check out:<br />
{% for row in rows %}
	<a class="btn btn-primary btn-large btn-block btn-checkin-select" href="/checkout?checkout={{ row.CheckOutId }}">{{ row.Name }}<span class="checkin-sub-title">{{ row.StartDateTime | HumanizeDateTime }}</span></a>
{% endfor %}', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPersonReportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddStoredProcedureId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowCommunicateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergePersonId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowBulkUpdateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowExcelExportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergeTemplateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPageTitleLavaId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowGridFilterId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddTimeoutId, @BlockId, '30', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPaneledGridId, @BlockId, 'False', NEWID());

INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_SelfCheckoutPageId, @b_HtmlBlockTypeId, 'Main', 3, "Bulk Checkout Link", 0, @b_BulkCheckoutLinkGuid);
SET @BlockId = (SELECT [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutLinkGuid);
INSERT INTO [HtmlContent] ([BlockId], [Version], [Content], [IsApproved], [Guid]) VALUES (@BlockId, 1, '<a style="position:fixed;bottom:1em;right:3em;color:rgba(255,255,255,0.5);z-index:1000;" href="/checkout/bulk"><i class="fa fa-sign-out fa-4x"></i></a>', 1, NEWID());
	
-- Create blocks on bulk checkout page
INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_BulkCheckoutPageId, @b_DynamicDataBlockTypeId, 'Main', 0, "Bulk Checkout SQL", 0, @b_BulkCheckoutSqlGuid);
SET @BlockId = (SELECT [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutSqlGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, 'performCheckout=0;coyyyy=1980;comm=01;codd=01;cohh=0;comin=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'UPDATE
	[Attendance]
SET
	[EndDateTime]=CONVERT(datetime, @coyyyy + '-' + @comm + '-' + @codd + ' ' + @cohh + ':' + @comin + ':00', 120)
WHERE
	@performCheckout=1
	AND [ScheduleId] IS NOT NULL
	AND [StartDateTime] > ''{{ "Now" | Date:"yyyy-M-d" }}''
	AND [EndDateTime] IS NULL;
SELECT @@ROWCOUNT AS ''Updated'' WHERE @performCheckout=1;', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '{% for row in rows %}{{ row.Updated }} people checked out{% endfor %}', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPersonReportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddStoredProcedureId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowCommunicateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergePersonId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowBulkUpdateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowExcelExportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergeTemplateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPageTitleLavaId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowGridFilterId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddTimeoutId, @BlockId, '30', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPaneledGridId, @BlockId, 'False', NEWID());

INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_BulkCheckoutPageId, @b_DynamicDataBlockTypeId, 'Main', 1, "People List", 0, @b_BulkCheckoutListGuid);
SET @BlockId = (SELECT [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutListGuid);
NSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, '@performCheckout=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'SELECT
	a.[Id]
	,''<img src="/GetImage.ashx?id='' + CAST(p.[PhotoId] as varchar(10)) + ''&maxwidth=50&maxheight=50">'' AS "img"
	,p.[NickName] + '' '' + p.[LastName] AS "Name"
	,g.[Name] "Group"
	,l.[Name] "Location"
	,a.[StartDateTime]
	,''<a class="btn btn-danger btn-sm grid-delete-button" href="/page/{{ PageParameter.PageId }}?checkout='' + CAST(a.[Id] as varchar(10)) + ''"><i class="fa fa-times"></i></a>'' AS "CheckOut"
FROM
	[Attendance] a
	LEFT JOIN [PersonAlias] pa ON a.[PersonAliasId]=pa.[Id]
	LEFT JOIN [Person] p ON pa.[PersonId] = p.[Id]
	LEFT JOIN [Group] g ON a.[GroupId]=g.[Id]
	LEFT JOIN [Location] l ON a.[LocationId]=l.[Id]
	LEFT JOIN [Campus] c ON a.[CampusId]=c.[Id]
WHERE
	a.[ScheduleId] IS NOT NULL
	AND a.[StartDateTime] > ''{{ "Now" | Date:"yyyy-M-d" }}''
	AND a.[EndDateTime] IS NULL
	AND @performCheckout=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '<h1>Checked in people:</h1>
<table class="grid-table table table-bordered table-hover">
	<thead>
		<tr>
			<th></th>
			<th>Name</th>
			<th>Group</th>
			<th>Location</th>
			<th>Checked in</th>
		</tr>
	</thead>
	<tbody>{% for row in rows %}
		<tr>
			<td>{{ row.img }}</input></td>
			<td>{{ row.Name }}</td>
			<td>{{ row.Group }}</td>
			<td>{{ row.Location }}</td>
			<td>{{ row.StartDateTime | HumanizeDateTime }}</td>
		</tr>
	{% endfor %}</tbody>
</table>
<style>
span.DateControl {
	border:1px solid black;
	background-color:#fff;
	color:#000;
}
span.DateControl input {
	border:0px;
	background:transparent;
	text-align:center;
	color:#000;
}
</style>
<div style="display:inline-block;padding-right:4em;">
	Date: (MM/DD/YYYY)<br />
	<span class="DateControl">
		<input type="number" id="iMM" maxlength="2" style="width:3em;" onFocus="this.select()" onKeyUp="if (this.value.length==2) {setTimeout(function(){ document.getElementById(''iDD'').focus();},125)}" value="{{ ''Now'' | Date:''MM'' }}" />/<input type="number" id="iDD" maxlength="2" style="width:3em;" onFocus="this.select()" onKeyUp="if (this.value.length==2) {setTimeout(function(){ document.getElementById(''iYYYY'').focus();},125)}" value="{{ ''Now'' | Date:''dd'' }}" />/<input type="number" id="iYYYY" maxlength="4" style="width:4em;" onFocus="this.select()" onKeyUp="if (this.value.length==4) {setTimeout(function(){ document.getElementById(''iHH'').focus();},125)}" value="{{ ''Now'' | Date:''yyyy'' }}" />
	</span>
</div>
<div style="display:inline-block;padding-right:4em;">
	Time: (24 hour)<br />
	<span class="DateControl">
		<input type="number" id="iHH" maxlength="2" style="width:3em;" onFocus="this.select()" onKeyUp="if (this.value.length==2) {setTimeout(function(){ document.getElementById(''iMin'').focus();},125)}" value="{{ ''Now'' | Date:''HH'' }}" />:<input type="number" id="iMin" maxlength="2" style="width:3em;" value="{{ ''Now'' | Date:''mm'' }}" />
	</span>
</div>
<span onClick="checkoutBulk()" class="btn btn-primary">Check out all</span>
<script>
function checkoutBulk() {
	window.location.href=window.location.pathname + ''?performCheckout=1&coyyyy='' + document.getElementById(''iYYYY'').value + ''&comm='' + document.getElementById(''iMM'').value + ''&codd='' + document.getElementById(''iDD'').value + ''&cohh='' + document.getElementById(''iHH'').value + ''&comin='' + document.getElementById(''iMin'').value;
}
</script>', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPersonReportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddStoredProcedureId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowCommunicateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergePersonId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowBulkUpdateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowExcelExportId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowMergeTemplateId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPageTitleLavaId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowGridFilterId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddTimeoutId, @BlockId, '30', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddPaneledGridId, @BlockId, 'False', NEWID());

INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_BulkCheckoutPageId, @b_HtmlBlockTypeId, 'Main', 2, "Self-Checkout Link", 0, @b_SelfCheckoutLinkGuid);

SET @BlockId = (SELECT [Id] FROM [Block] WHERE [Guid] = @b_SelfCheckoutLinkGuid);
INSERT INTO [HtmlContent] ([BlockId], [Version], [Content], [IsApproved], [Guid]) VALUES (@BlockId, 1, '<a style="position:fixed;bottom:1em;right:3em;color:rgba(255,255,255,0.5);z-index:1000;" href="/checkout"><i class="fa fa-backward fa-4x"></i></a>', 1, NEWID());