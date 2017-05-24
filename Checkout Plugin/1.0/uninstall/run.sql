DECLARE @p_SelfCheckoutPageGuid AS UNIQUEIDENTIFIER = '34dc70e8-58a8-43e3-b2ba-f4b2b656ebd6';
DECLARE @p_BulkCheckoutPageGuid AS UNIQUEIDENTIFIER = 'ec6fd761-f343-491a-90b1-c63370b12cc9';

DECLARE @p_SelfCheckoutPageId AS INT = (SELECT TOP 1 [Id] FROM [Page] WHERE [Guid] = @p_SelfCheckoutPageGuid);
DECLARE @p_BulkCheckoutPageId AS INT = (SELECT TOP 1 [Id] FROM [Page] WHERE [Guid] = @p_BulkCheckoutPageGuid);

--DECLARE @r_CheckoutPageRouteGuid AS UNIQUEIDENTIFIER = '21229c4b-41f0-4a71-ad61-4ddb7401cbda';

DECLARE @b_SelfCheckoutUndoGuid AS UNIQUEIDENTIFIER = '0e8ca1d9-ff27-43e9-9817-3c8d0e52e640';
DECLARE @b_SelfCheckoutUndoId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_SelfCheckoutUndoGuid);
DECLARE @b_SelfCheckoutSqlGuid AS UNIQUEIDENTIFIER = '1248629e-039f-4263-8d23-c3f5a4f52859';
DECLARE @b_SelfCheckoutSqlId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_SelfCheckoutSqlGuid);
DECLARE @b_SelfCheckoutListGuid AS UNIQUEIDENTIFIER = '666d60e0-7a53-4eb2-b00c-1b9caceb11c7';
DECLARE @b_SelfCheckoutListId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_SelfCheckoutListGuid);
DECLARE @b_BulkCheckoutLinkGuid AS UNIQUEIDENTIFIER = '44b42068-25d4-4a24-ac8d-450ab1e20976';
DECLARE @b_BulkCheckoutLinkId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutLinkGuid);
DECLARE @b_BulkCheckoutSqlGuid AS UNIQUEIDENTIFIER = '23038704-d899-4567-8c24-1b4f791faabd';
DECLARE @b_BulkCheckoutSqlId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutSqlGuid);
DECLARE @b_BulkCheckoutListGuid AS UNIQUEIDENTIFIER = '7a4018fd-dd4c-4dcf-b8e1-8aef4fd0512d';
DECLARE @b_BulkCheckoutListId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutListGuid);
DECLARE @b_SelfCheckoutLinkGuid AS UNIQUEIDENTIFIER = '1ab07025-b0ee-4477-bd42-e2d0736d3391';
DECLARE @b_SelfCheckoutLinkId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_SelfCheckoutLinkGuid);

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

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_SelfCheckoutUndoId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_SelfCheckoutSqlId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_SelfCheckoutListId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_BulkCheckoutLinkId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_BulkCheckoutSqlId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_BulkCheckoutListId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_SelfCheckoutLinkId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

SET @BlockId = (SELECT [Id] FROM [Block] WHERE [Guid] = @b_BulkCheckoutLinkGuid);
DELETE FROM [HtmlContent] WHERE [BlockId]=@BlockId

SET @BlockId = (SELECT [Id] FROM [Block] WHERE [Guid] = @b_SelfCheckoutLinkGuid);
DELETE FROM [HtmlContent] WHERE [BlockId]=@BlockId

DELETE FROM [Block] WHERE [PageId] IN (@p_SelfCheckoutPageId,@p_BulkCheckoutPageId);

DELETE FROM [Page] WHERE [Guid] IN (@p_SelfCheckoutPageGuid,@p_BulkCheckoutPageGuid);

DELETE FROM [PageRoute] WHERE [PageId]=@p_SelfCheckoutPageId