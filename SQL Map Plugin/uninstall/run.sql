DECLARE @p_SqlMapPageGuid AS UNIQUEIDENTIFIER = 'b836c006-d156-4deb-a6de-6db17f6894b1';
DECLARE @p_SqlMapPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid]=@p_SqlMapPageGuid);

DECLARE @i_BlockEntityTypeId AS INT = (SELECT [Id] FROM [EntityType] WHERE [Name]='Rock.Model.Block'); --should be 9
DECLARE @b_DynamicDataBlockTypeId AS INT = (SELECT [Id] FROM [BlockType] WHERE [Guid] = 'e31e02e9-73f6-4b3e-98ba-e0e4f86ca126'); --should be 143

DECLARE @b_SqlMapGuid AS UNIQUEIDENTIFIER = '37cd62e9-ee3d-4403-a010-04048f3f2fe8';
DECLARE @b_SqlMapId AS INT = (SELECT TOP 1 [Id] FROM [Block] WHERE [Guid]=@b_SqlMapGuid);

DECLARE @a_ddUpdatePageId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='UpdatePage');
DECLARE @a_ddQueryParamsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='QueryParams');
DECLARE @a_ddColumnsId AS INT = (SELECT [Id] FROM [Attribute] WHERE[EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Columns');
DECLARE @a_ddQueryId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Query');
DECLARE @a_ddUrlMaskId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='UrlMask');
DECLARE @a_ddShowColumnsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowColumns');
DECLARE @a_ddMergeFieldsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='MergeFields');
DECLARE @a_ddFormattedOutputId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='FormattedOutput');
DECLARE @a_ddPersonReportId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PersonReport');
DECLARE @a_ddStoredProcedureId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='StoredProcedure');
DECLARE @a_ddShowCommunicateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowCommunicate');
DECLARE @a_ddShowMergePersonId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowMergePerson');
DECLARE @a_ddShowBulkUpdateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowBulkUpdate');
DECLARE @a_ddShowExcelExportId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowExcelExport');
DECLARE @a_ddShowMergeTemplateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowMergeTemplate');
DECLARE @a_ddPageTitleLavaId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PageTitleLava');
DECLARE @a_ddShowGridFilterId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowGridFilter');
DECLARE @a_ddTimeoutId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Timeout');
DECLARE @a_ddPaneledGridId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PaneledGrid');

DELETE FROM [AttributeValue] WHERE
	[EntityId] = @b_SqlMapId
	AND [AttributeId] IN (@a_ddUpdatePageId,@a_ddQueryParamsId,@a_ddColumnsId,@a_ddQueryId,@a_ddUrlMaskId,@a_ddShowColumnsId,@a_ddMergeFieldsId,@a_ddFormattedOutputId,@a_ddPersonReportId,@a_ddStoredProcedureId,@a_ddShowCommunicateId,@a_ddShowMergePersonId,@a_ddShowBulkUpdateId,@a_ddShowMergeTemplateId,@a_ddPageTitleLavaId,@a_ddShowGridFilterId,@a_ddTimeoutId,@a_ddPaneledGridId);

DELETE FROM [Block] WHERE [PageId] = @p_SqlMapPageId;

UPDATE [PageView] SET [PageId] = null WHERE [PageId]=@p_SqlMapPageId;

DELETE FROM [Page] WHERE [Guid] = @p_SqlMapPageGuid;