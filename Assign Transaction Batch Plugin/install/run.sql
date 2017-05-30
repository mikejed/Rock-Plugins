DECLARE @p_ParentPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid]='18c9e5c3-3e28-4aa3-84f6-78cd4ea2dd3c');
DECLARE @i_ChildId AS INT = (SELECT TOP 1 [Order] FROM [Page] WHERE [ParentPageId]=@p_ParentPageId ORDER BY [Order] DESC)+1;

DECLARE @p_BatchlessTransactionsPageGuid AS UNIQUEIDENTIFIER = 'e11f8806-f048-4213-bc2e-10bbeffb93c7';
DECLARE @p_AssignBatchPageGuid AS UNIQUEIDENTIFIER = 'da0c9729-3804-4b5b-9d65-779da2645a4d';

DECLARE @l_FullWidthLayoutId = (SELECT [Id] FROM [Layout] WHERE REPLACE([Name],' ','')='FullWidth' AND [SiteId] = (SELECT [Id] FROM [Site] WHERE [Guid]='c2d29296-6a87-47a9-a753-ee4e9159c4c4'));
DECLARE @l_LeftSidebarLayoutId = (SELECT [Id] FROM [Layout] WHERE REPLACE([Name],' ','')='LeftSidebar' AND [SiteId] = (SELECT [Id] FROM [Site] WHERE [Guid]='c2d29296-6a87-47a9-a753-ee4e9159c4c4'));

DECLARE @b_DynamicDataBlockTypeId AS INT = (SELECT [Id] FROM [BlockType] WHERE [Guid] = 'e31e02e9-73f6-4b3e-98ba-e0e4f86ca126'); --should be 143

DECLARE @b_ListGuid AS UNIQUEIDENTIFIER = '91b7a1ac-c302-428b-865a-5dab3a391ecf';
DECLARE @b_BatchSelectionGuid AS UNIQUEIDENTIFIER = 'cb179ae3-c626-4ce9-b476-b04bd982420e';
DECLARE @b_MoveTransactionsGuid AS UNIQUEIDENTIFIER = '730ce4d0-db0a-491c-a54a-c8e3dea8feab';
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

-- Create the Batchless Transactions page
INSERT INTO [Page]
	([InternalName], [ParentPageId], [PageTitle], [IsSystem], [LayoutId], [EnableViewState], [PageDisplayTitle], [PageDisplayBreadCrumb], [PageDisplayIcon], [PageDisplayDescription], [DisplayInNavWhen], [MenuDisplayChildPages], [BreadCrumbDisplayName], [Order], [OutputCacheDuration], [IncludeAdminFooter], [Guid], [BrowserTitle])
	VALUES
	("Move Batch-less Transactions", @p_ParentPageId, "Move Batch-less Transactions", 0, @l_LeftSidebarLayoutId, 1, 1, 1, 1, 1, 0, 1, 1, @i_ChildId, 0, 1, @p_BatchlessTransactionsPageGuid, "Move Batch-less Transactions");

-- Store the Page ID for the Batchless Transactions page
DECLARE @p_BatchlessTransactionsPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_BatchlessTransactionsPageGuid);

-- Create the Batchless Transactions page
INSERT INTO [Page]
	([InternalName], [ParentPageId], [PageTitle], [IsSystem], [LayoutId], [EnableViewState], [PageDisplayTitle], [PageDisplayBreadCrumb], [PageDisplayIcon], [PageDisplayDescription], [DisplayInNavWhen], [MenuDisplayChildPages], [BreadCrumbDisplayName], [Order], [OutputCacheDuration], [IncludeAdminFooter], [Guid], [BrowserTitle])
	VALUES
	("Assign Batch", @p_ParentPageId, "Assign Batch", 0, @l_FullWidthLayoutId, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, @p_AssignBatchPageGuid, "Assign Batch");

-- Store the Page ID for the Batchless Transactions page
DECLARE @p_AssignBatchPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_AssignBatchPageGuid);


-- Create blocks on Batchless Transactions page
INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_BatchlessTransactionsPageId, @b_DynamicDataBlockTypeId, 'Sidebar1', 0, "Count", 0, @b_ListGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_ListGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, 'date=1980-01-01', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'SELECT
    cast([TransactionDateTime] AS Date) "Date",
    count(*) "Transactions"
FROM
    [FinancialTransaction]
WHERE
    [BatchId] IS NULL
    AND (
        cast([TransactionDateTime] AS Date)=@date
        OR @date=''1980-01-01''
    )
GROUP BY
    cast([TransactionDateTime] AS Date)', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '<h3>Transactions to move into a batch:</h3><p>(click on a date to only move that date''s transactions)<br />&nbsp;<br />{% for row in rows %}
    <a href="/page/{{ PageParameter.PageId }}?date={{ row.Date | Date:''yyyy-MM-dd'' }}">{{ row.Date | Date:''M/d/yyyy'' }}</a>: {{ row.Transactions }} transactions<br />
{% endfor %}', NEWID());
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
	(0, @p_BatchlessTransactionsPageId, @b_DynamicDataBlockTypeId, 'Main', 1, "Batch Selection", 0, @b_BatchSelectionGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_BatchSelectionGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, 'date=1980-01-01', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'SELECT @date AS "Date";
SELECT [Id],[Name] FROM [FinancialBatch] WHERE [Status]=0', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '<h3>Batch to move transactions into:</h3>
<p>(Batch status must be "pending")</p>
<input type="hidden" id="seldate" name="seldate" value="{% for row in table1.rows %}{{ row.Date }}{% endfor %}">
<select id="batchId" name="batchId">
    {% for row in table2.rows %}<option value="{{ row.Id }}">{{ row.Name }}</option>{% endfor %}
</select>
<p style="margin-top:1em;"><input type="button" value="Move all of the transactions listed to the left now!" onClick=''window.location.href="/page/' + @p_AssignBatchPageId + '?date=" + seldate.value + "&batchId=" + batchId.value'' /></p>', NEWID());
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

-- Create block on Move Transactions page
INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_AssignBatchPageId, @b_DynamicDataBlockTypeId, 'Feature', 0, "Move Transactions", 0, @b_MoveTransactionsGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_ListGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, 'batchId=null;date=1980-01-01', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'UPDATE
    [FinancialTransaction]
SET
    [BatchId]=@batchId
WHERE
    [BatchId] IS NULL
    AND (
        cast([TransactionDateTime] AS Date)=@date
        OR @date=''1980-01-01''
    );
SELECT @@ROWCOUNT "count", [Name] FROM [FinancialBatch] WHERE [Id]=@batchId;', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '{% for row in rows %}<h3>{{ row.count }} transactions moved to {{ row.Name }}.</h3>{% endfor %}Taking you back...<script>window.location.href=''/page/' + @BatchlessTransactionsPageId + ''';</script>', NEWID());
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