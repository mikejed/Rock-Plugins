DECLARE @t_ExternalApplicationDefinedTypeGuid AS UNIQUEIDENTIFIER = '1fac459c-5f62-4e7c-8933-61ff9fe2dfef';
DECLARE @i_ExternalApplicationDefinedTypeId AS INT = (SELECT [Id] FROM [DefinedType] WHERE [Guid] = @t_ExternalApplicationDefinedTypeGuid);

DECLARE @i_ExternalApplication_IconAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'Icon');
DECLARE @i_ExternalApplication_VendorAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'Vendor');
DECLARE @i_ExternalApplication_DownloadUrlAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'DownloadUrl');

DECLARE @g_PrintBlanksDVGuid AS UNIQUEIDENTIFIER = 'b138de05-b4b2-4c6a-a2de-079c8df55be8';
DECLARE @i_PrintBlanksDVId AS INT = (SELECT TOP 1 [Id] FROM [DefinedValue] WHERE [Guid] = @g_PrintBlanksDVGuid);
DECLARE @g_BinaryFile_PrintBlanksGuid AS UNIQUEIDENTIFIER = '543dab6f-f604-4b92-a03e-1469008d1059';
DECLARE @i_BinaryFile_DatabaseStorageId AS INT= (SELECT TOP 1 [Id] FROM [EntityType] WHERE [Name] = 'Rock.Storage.Provider.Database');
DECLARE @i_BinaryFile_PrintBlanksIconId AS INT = (SELECT [Id] FROM [BinaryFile] WHERE [Guid] = @g_BinaryFile_PrintBlanksGuid);

DELETE FROM [DefinedValue] WHERE [Guid] = @g_PrintBlanksDVGuid;
DELETE FROM [BinaryFile] WHERE [Guid] = @g_BinaryFile_PrintBlanksGuid;
DELETE FROM [BinaryFileData] WHERE [Id] = @i_BinaryFile_PrintBlanksIconId;

DELETE FROM [AttributeValue] WHERE [EntityId] = @i_PrintBlanksDVId AND [AttributeId] = @i_ExternalApplication_IconAttributeId;
DELETE FROM [AttributeValue] WHERE [EntityId] = @i_PrintBlanksDVId AND [AttributeId] = @i_ExternalApplication_VendorAttributeId;
DELETE FROM [AttributeValue] WHERE [EntityId] = @i_PrintBlanksDVId AND [AttributeId] = @i_ExternalApplication_DownloadUrlAttributeId;