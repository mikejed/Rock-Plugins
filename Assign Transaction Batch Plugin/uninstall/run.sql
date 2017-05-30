DECLARE @p_BatchlessTransactionsPageGuid AS UNIQUEIDENTIFIER = 'e11f8806-f048-4213-bc2e-10bbeffb93c7';
DECLARE @p_AssignBatchPageGuid AS UNIQUEIDENTIFIER = 'da0c9729-3804-4b5b-9d65-779da2645a4d';

DECLARE @p_BatchlessTransactionsPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_BatchlessTransactionsPageGuid);
DECLARE @p_AssignBatchPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_AssignBatchPageGuid);

DECLARE @b_ListGuid AS UNIQUEIDENTIFIER = '91b7a1ac-c302-428b-865a-5dab3a391ecf';
DECLARE @b_ListId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_ListGuid);
DECLARE @b_BatchSelectionGuid AS UNIQUEIDENTIFIER = 'cb179ae3-c626-4ce9-b476-b04bd982420e';
DECLARE @b_BatchSelectionId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_BatchSelectionGuid);
DECLARE @b_MoveTransactionsGuid AS UNIQUEIDENTIFIER = '730ce4d0-db0a-491c-a54a-c8e3dea8feab';
DECLARE @b_MoveTransactionsId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid] = @b_MoveTransactionsGuid);

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
	[EntityId] = @b_ListId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_BatchSelectionId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);
	
DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_MoveTransactionsId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [Block] WHERE [PageId] IN (@p_BatchlessTransactionsPageId,@p_AssignBatchPageId);

DELETE FROM [Page] WHERE [Guid] IN (@p_BatchlessTransactionsPageGuid,@p_AssignBatchPageGuid);