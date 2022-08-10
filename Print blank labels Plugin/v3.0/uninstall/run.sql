DECLARE @PrintBlanksChecklistGuid UNIQUEIDENTIFIER = '22edfb87-2e9c-428e-a1fc-c86df4e74d6a';
DELETE FROM [DefinedValue] WHERE [Guid] = @PrintBlanksChecklistGuid;