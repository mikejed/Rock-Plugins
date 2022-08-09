DECLARE @t_ExternalApplicationDefinedTypeGuid AS UNIQUEIDENTIFIER = '1fac459c-5f62-4e7c-8933-61ff9fe2dfef';
DECLARE @i_ExternalApplicationDefinedTypeId AS INT = (SELECT [Id] FROM [DefinedType] WHERE [Guid] = @t_ExternalApplicationDefinedTypeGuid);

DECLARE @g_PrintBlanksDVGuid AS UNIQUEIDENTIFIER = 'b138de05-b4b2-4c6a-a2de-079c8df55be8';
DECLARE @i_PrintBlanksDVId AS INT = (SELECT TOP 1 [Id] FROM [DefinedValue] WHERE [Guid] = @g_PrintBlanksDVGuid);

DECLARE @i_ExternalApplication_DownloadUrlAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'DownloadUrl');

UPDATE [DefinedValue]
	SET [Description] = 'Allows you to load and print labels from your computer or your remote server, for testing or times when check-in is not accessible for environmental reasons (network issues, power outage, etc). You will be able to specify how each field behaves; whether it prints text, generates a random security code, or gets hidden.'
	WHERE [Guid] = @g_PrintBlanksDVGuid;

UPDATE [AttributeValue]
	SET [Value] = 'https://github.com/mikejed/Rock-Plugins/raw/master/Print%20blank%20labels%20Plugin/v3.0/PrintBlanks3.0.exe'
	WHERE
		[AttributeId] = @i_ExternalApplication_DownloadUrlAttributeId
		AND [EntityId] = @i_PrintBlanksDVId;
