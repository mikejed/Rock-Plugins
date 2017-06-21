DECLARE @p_PowerToolsPageGuid AS UNIQUEIDENTIFIER = '7f1f4130-cb98-473b-9de1-7a886d2283ed';
DECLARE @p_PowerToolsPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_PowerToolsPageGuid);
DECLARE @i_ChildId AS INT = (SELECT TOP 1 [Order] FROM [Page] WHERE [ParentPageId]=@p_PowerToolsPageId ORDER BY [Order] DESC)+1;

DECLARE @p_SqlMapPageGuid AS UNIQUEIDENTIFIER = 'b836c006-d156-4deb-a6de-6db17f6894b1';

DECLARE @l_FullWidthLayoutId AS INT = (SELECT [Id] FROM [Layout] WHERE REPLACE([Name],' ','')='FullWidth' AND [SiteId] = (SELECT [Id] FROM [Site] WHERE [Guid]='c2d29296-6a87-47a9-a753-ee4e9159c4c4'));

DECLARE @i_BlockEntityTypeId AS INT = (SELECT [Id] FROM [EntityType] WHERE [Name]='Rock.Model.Block'); --should be 9
DECLARE @b_DynamicDataBlockTypeId AS INT = (SELECT [Id] FROM [BlockType] WHERE [Guid] = 'e31e02e9-73f6-4b3e-98ba-e0e4f86ca126'); --should be 143

DECLARE @b_SqlMapGuid AS UNIQUEIDENTIFIER = '37cd62e9-ee3d-4403-a010-04048f3f2fe8';
DECLARE @BlockId AS INT;

-- Get DD attribute IDs
DECLARE @a_ddUpdatePageId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='UpdatePage');
DECLARE @a_ddQueryParamsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='QueryParams');
DECLARE @a_ddColumnsId AS INT = (SELECT [Id] FROM [Attribute] WHERE[EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Columns');
DECLARE @a_ddQueryId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Query');
DECLARE @a_ddUrlMaskId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='UrlMask');
DECLARE @a_ddShowColumnsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowColumns');
DECLARE @a_ddMergeFieldsId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='MergeFields');
DECLARE @a_ddFormattedOutputId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='FormattedOutput');
DECLARE @a_ddPersonReportId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PersonReport');

-- Below DD attributes are not available to Rock until the first DD block is inserted. Instead of using MigrationHelper (C#), conditionally create the attributes manually before getting the ID.
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='StoredProcedure') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'StoredProcedure','Stored Procedure','Is the query a stored procedure?','0','0','FALSE','0','0',NEWID(),'0');
DECLARE @a_ddStoredProcedureId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='StoredProcedure');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowCommunicate') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'ShowCommunicate','Show Communicate','Show Communicate button in grid footer?','0','0','TRUE','0','0',NEWID(),'0');
DECLARE @a_ddShowCommunicateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowCommunicate');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowMergePerson') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'ShowMergePerson','Show Merge Person','Show Merge Person button in grid footer?','0','0','TRUE','0','0',NEWID(),'0');
DECLARE @a_ddShowMergePersonId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowMergePerson');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowBulkUpdate') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'ShowBulkUpdate','Show Bulk Update','Show Bulk Update button in grid footer?','0','0','TRUE','0','0',NEWID(),'0');
DECLARE @a_ddShowBulkUpdateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowBulkUpdate');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowExcelExport') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'ShowExcelExport','Show Excel Export','Show Export to Excel button in grid footer?','0','0','TRUE','0','0',NEWID(),'0');
DECLARE @a_ddShowExcelExportId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowExcelExport');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowMergeTemplate') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'ShowMergeTemplate','Show Merge Template','Show Export to Merge Template button in grid footer?','0','0','TRUE','0','0',NEWID(),'0');
DECLARE @a_ddShowMergeTemplateId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowMergeTemplate');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PageTitleLava') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','51',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'PageTitleLava','Page Title Lava','Optional Lava for setting the page title. If nothing is provided then the page''s title will be used.','0','0','NULL','0','0',NEWID(),'0');
DECLARE @a_ddPageTitleLavaId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PageTitleLava');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowGridFilter') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'ShowGridFilter','Show Grid Filter','Show filtering controls that are dynamically generated to match the columns of the dynamic data.','0','0','TRUE','0','0',NEWID(),'0');
DECLARE @a_ddShowGridFilterId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='ShowGridFilter');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Timeout') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','7',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'Timeout','Timeout','The amount of time in xxx to allow the query to run before timing out.','0','0','30','0','0',NEWID(),'0');
DECLARE @a_ddTimeoutId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='Timeout');
IF (SELECT count(*) FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PaneledGrid') = 0
	INSERT INTO [Attribute] ([IsSystem],[FieldTypeId],[EntityTypeId],[EntityTypeQualifierColumn],[EntityTypeQualifierValue],[Key],[Name],[Description],[Order],[IsGridColumn],[DefaultValue],[IsMultiValue],[IsRequired],[Guid],[AllowSearch]) VALUES ('0','3',@i_BlockEntityTypeId,'BlockTypeId',@b_DynamicDataBlockTypeId,'PaneledGrid','Paneled Grid','Add the ''grid-panel'' class to the grid to allow it to fit nicely in a block.','0','0','FALSE','0','0',NEWID(),'0');
DECLARE @a_ddPaneledGridId AS INT = (SELECT [Id] FROM [Attribute] WHERE [EntityTypeId]=@i_BlockEntityTypeId AND [EntityTypeQualifierColumn]='BlockTypeId' AND [EntityTypeQualifierValue]=@b_DynamicDataBlockTypeId AND [Key]='PaneledGrid');

-- Create the SQL Map page
INSERT INTO [Page]
	([InternalName],	[ParentPageId],			[PageTitle],	[IsSystem],	[LayoutId],				[RequiresEncryption],	[EnableViewState],	[PageDisplayTitle],	[PageDisplayBreadCrumb],	[PageDisplayIcon],	[PageDisplayDescription],	[DisplayInNavWhen],	[MenuDisplayDescription],	[MenuDisplayIcon],	[MenuDisplayChildPages],	[BreadCrumbDisplayName],	[BreadCrumbDisplayIcon],	[Order],	[OutputCacheDuration],	[IconCssClass],		[IncludeAdminFooter],	[Guid],				[BrowserTitle],	[AllowIndexing])
	VALUES
	('SQL Map',			@p_PowerToolsPageId,	'SQL Map',		0,			@l_FullWidthLayoutId,	0,						1,					1,					1,							1,					1,							0,					'',							0,					1,							1,							0,							@i_ChildId,	0,						'fa fa-database',	1,						@p_SqlMapPageGuid,	'SQL Map',		1);

-- Store the Page ID for the SQL Map page
DECLARE @p_SqlMapPageId AS INT = (SELECT [Id] FROM [Page] WHERE [Guid] = @p_SqlMapPageGuid);

-- Create DD block on SQL Map page
INSERT INTO [Block]
	([IsSystem], [PageId], [BlockTypeId], [Zone], [Order], [Name], [OutputCacheDuration], [Guid])
	VALUES
	(0, @p_SqlMapPageId, @b_DynamicDataBlockTypeId, 'Main', 0, 'SQL Map', 0, @b_SqlMapGuid);
SET @BlockId = (SELECT [ID] FROM [Block] WHERE [Guid] = @b_SqlMapGuid);
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUpdatePageId, @BlockId, 'True', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryParamsId, @BlockId, 'date=1980-01-01', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddColumnsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddQueryId, @BlockId, 'SELECT 
  OBJECT_NAME(f.parent_object_id) AS TableName
  ,COL_NAME(fc.parent_object_id,fc.parent_column_id) AS ColumnName
  ,OBJECT_NAME (f.referenced_object_id) AS ReferenceTableName
  ,COL_NAME(fc.referenced_object_id,fc.referenced_column_id) AS ReferenceColumnName
  ,f.name AS ForeignKey
INTO #tempFKs
FROM
  sys.foreign_keys AS f
  INNER JOIN sys.foreign_key_columns AS fc ON f.OBJECT_ID = fc.constraint_object_id;

SELECT 
    o.name ''TableName''
    ,c.name ''ColumnName''
    ,ISNULL(r.[TableName] + ''.'' + r.[ColumnName], '''') ''ReferencedBy''
    ,ISNULL(rb.[ReferenceTableName] + ''.'' + rb.[ReferenceColumnName], '''') ''References''
    ,t.[name] ''coltype''
    ,c.[max_length]
    ,c.[is_nullable]
    FROM sys.columns c
        INNER JOIN sys.objects o on c.object_id=o.object_id
        INNER JOIN SYS.TYPES t ON C.system_type_id = t.user_type_id
	LEFT JOIN #tempFKs r ON r.[ReferenceTableName]=o.[name] AND r.[ReferenceColumnName]=c.[name]
	LEFT JOIN #tempFKs rb on rb.[TableName]=o.[name] AND rb.[ColumnName]=c.[name]
	WHERE o.[is_ms_shipped] = 0
    order by o.name,c.column_id;', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddUrlMaskId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddShowColumnsId, @BlockId, 'False', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddMergeFieldsId, @BlockId, '', NEWID());
INSERT INTO [AttributeValue] ([IsSystem], [AttributeId], [EntityId], [Value], [Guid]) VALUES (0, @a_ddFormattedOutputId, @BlockId, '<div><span style="color:red;">*</span> = not nullable</div>
{% assign tableName = '''' %}
{% assign columnName = '''' %}
{% assign rs = '''' %}
{% assign rb = '''' %}

 {% for row in rows %} 
    
    <!-- start a new row? -->
    {% if columnName != row.ColumnName or tableName != row.TableName %}
        
        <!-- end row if not the first item -->
        {% if columnName != '''' %}
            <td>{{rb}}</td><td>{{rs}}</td></tr>
        {% endif %}

        {% assign columnName = row.ColumnName %}
        {% assign rs = '''' %}
        {% assign rb = '''' %}
    
    <!-- start a new table? -->
        {% if tableName != row.TableName %}
            
            <!-- end table if not the first item -->
            {% if tableName != '''' %}
                </table>
            {% endif %}
    
            {% assign tableName = row.TableName %}
            
            <a name="{{ row.TableName }}"></a><h2><a href="#{{ row.TableName }}"><i class="fa fa-chain"></i></a> {{ row.TableName }}</h2>
            <table class=''table table-striped''>
                <tr>
                    <th style="width:20%;">Column</th><th>Referenced by</th><th>References</th>
                </tr>
            
        {% endif %}
    
    <tr><td><a name="{{ row.TableName }}.{{ row.ColumnName }}"></a>{{ row.ColumnName }}{% if row.is_nullable == 0 %} <span style="color:red;">*</span>{% endif %}<div style="font-weight:lighter;"> {{ row.coltype }}({{ row.max_length }})</div></td>
        
    {% endif %}

    {% if row.References != empty %}{% capture rs %}{{ rs }}<a href="#{{ row.References }}">{{ row.References }}</a><br />{% endcapture %}{% endif %}
    {% if row.ReferencedBy != empty %}{% capture rb %}{{ rb }}<a href="#{{ row.ReferencedBy }}">{{ row.ReferencedBy }}</a><br />{% endcapture %}{% endif %}

 {% endfor %}
 
 </table>', NEWID());
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