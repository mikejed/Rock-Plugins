DECLARE @t_ExternalApplicationDefinedTypeGuid AS UNIQUEIDENTIFIER = '1fac459c-5f62-4e7c-8933-61ff9fe2dfef';
DECLARE @i_ExternalApplicationDefinedTypeId AS INT = (SELECT [Id] FROM [DefinedType] WHERE [Guid] = @t_ExternalApplicationDefinedTypeGuid);

DECLARE @i_ExternalApplication_IconAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'Icon');
DECLARE @i_ExternalApplication_VendorAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'Vendor');
DECLARE @i_ExternalApplication_DownloadUrlAttributeId AS INT = (SELECT TOP 1 [Id] FROM [Attribute] WHERE [EntityTypeQualifierValue] = @i_ExternalApplicationDefinedTypeId AND [Key] = 'DownloadUrl');

DECLARE @g_PrintBlanksDVGuid AS UNIQUEIDENTIFIER = 'b138de05-b4b2-4c6a-a2de-079c8df55be8';
DECLARE @i_PrintBlanksOrder AS INT = (SELECT TOP 1 [Id]+1 FROM [DefinedValue] WHERE [DefinedTypeId] = @i_ExternalApplicationDefinedTypeId);

INSERT INTO [DefinedValue] ([IsSystem],[DefinedTypeId],[Order],[Value],[Description],[Guid]) VALUES (
							0
							,@i_ExternalApplicationDefinedTypeId
							,@i_PrintBlanksOrder
							,'Print Blank Labels'
							,'Allows you to pre-print blank labels for times when check-in is not accessible for environmental reasons (network issues, power outage, etc). Any .prn files put in the same directory as this program will be printed to the printer you specify, with any occurrences of ??? in the ZPL replaced with a new security code.'
							,@g_PrintBlanksDVGuid
							);

DECLARE @i_PrintBlanksDVId AS INT = (SELECT TOP 1 [Id] FROM [DefinedValue] WHERE [Guid] = @g_PrintBlanksDVGuid);

DECLARE @i_BinaryFileTypeId AS INT = (SELECT TOP 1 [Id] FROM [BinaryFileType] WHERE [Guid] = 'c1142570-8cd6-4a20-83b1-acb47c1cd377');--"unsecured"
DECLARE @g_BinaryFile_PrintBlanksGuid AS UNIQUEIDENTIFIER = '543dab6f-f604-4b92-a03e-1469008d1059';
DECLARE @i_BinaryFile_DatabaseStorageId AS INT= (SELECT TOP 1 [Id] FROM [EntityType] WHERE [Name] = 'Rock.Storage.Provider.Database');

INSERT INTO [BinaryFile] ([IsSystem],[IsTemporary],[BinaryFileTypeId],[FileName],[MimeType],[StorageEntityTypeId],[Guid],[StorageEntitySettings],[Path]) VALUES (
							0
							,0
							,@i_BinaryFileTypeId
							,'PrintBlanks.png'
							,'image/png'
							,@i_BinaryFile_DatabaseStorageId
							,@g_BinaryFile_PrintBlanksGuid
							,'{}'
							,'~/GetImage.ashx?guid=' + CONVERT(nvarchar(max),@g_BinaryFile_PrintBlanksGuid)
							);
DECLARE @i_BinaryFile_PrintBlanksIconId AS INT = (SELECT [Id] FROM [BinaryFile] WHERE [Guid] = @g_BinaryFile_PrintBlanksGuid);
DECLARE @s_ThumbnailData AS VARBINARY(MAX) = 0x89504E470D0A1A0A0000000D49484452000001000000010008060000005C72A8660000000467414D410000B18F0BFC6105000000097048597300000EC200000EC20115284A800000001974455874536F667477617265007061696E742E6E657420342E302E3231F12069950000390D49444154785EED9D0FEC24C595DF6D62590EB6886DC0B131C29C6F59C0B2D8854578D702E4231C67ADC1E720821142C87208079663210216200B71ACC3718E8D38822C1FB210E11CCB42888495B5DA10B2419B3D4236167136885B6D080A5C7008221B8E701659914CE6D3D477EEFDEAF766A6FF54F774CFD4933E9ADFAFBABBBABABAAABAEAD5AB57EFC992254B962C59B264C992254B962C597C197DF2939F1C85BFB364C9B2EC72FCF1C78F3EF2918F50E9A7C23930FE3B4B962C439673CE396774CA29A7ACA9E01FFCE00747E79E7B6E810D77C89225CB90E4AB5FFDEA68F3E6CD6B2AF2873FFCE1D159679D35DAB66DDBE8924B2E99C9962D5B8A73B76FDF5EFC4F9C37DD74536E0CB264E9A3DC72CB2D45A51DFF39E1A31FFDE8E8B4D34E1BF1F58F2B781DAEBFFEFAD18E1D3B8AB8B91F8CFFCE9225CB22E48C33CE5853E119D39F74D249C92ABCC7A9A79E3ADAB56BD7E8DA6BAF9DDCF7EB5FFF3ABF59B26469534E3EF9E449A583638E39A650D26DDDBAD5ADAC6D73FFFDF78F366CD8307AFFFBDF3F49536818B264C9D25450D28D7F267CE0031F9828EEBC0AB90876EEDC59547AFE266DEF7BDFFB26E9BDE69A6BF8CD92254B4999541E78EF7BDF5B70E18517AEAB787DE39D77DE197DF9CB5F9EFC4FBAA3E7C992258B95134F3C7104E33FD74085878B2FBE784D25EB3B8F3DF6D8E8BEFBEE9BFCFFC52F7EB1D019E8B98E3EFAE8D1D7BEF635FECE9265F5E4FCF3CF1FC1F8CF357CFEF39F2FB09569A8D0EDBFE79E7BD685F37C1B376E2C9E1765E537BFF94DFECE926579E5EAABAF1EC1F8CF35303F0F71255916BEF5AD6F8D9E7CF249F798CD87E38E3B6E74DB6DB7F177962CC3973BEEB86304E33FD7C0970FBC0AB1CCFCE4273F5917F6852F7C615DFE04B26419ACAC29CC1ADBC7857F15F9D9CF7EB62ECC0E83AEB8E28AC9DF1FFAD087F8CD92A5BF8265DDF8670D58DC415CD033EF8272300EF37421224C2566C9B278A1628F7F2660F4C27C3CC4853A339DDDBB77BBE1D688C8214B966E85AF0FC4F3D88C5DBFF4A52F0D6E6AAE4FECDDBB775D18F969F3D9214B96F68425B2F13259A0C2ABD2C78536538FCB2EBBAC5847108793C771FE5B820974962CCDE5A28B2E1AC1F8CF357CEE739F2B880B67262D575E79E5E891471E5917CEB2E3F89D58CE3BEF3C7EB364A926D8A9DB956B8295741017C44CFBFCF8C73F76C3E73502812C594AC99A82C3AA35F00A5EA67BBCE94198D608841E80C892659DD802323AE184130ABC4296E907870E1D72C3817717BF533C1499FFB3ACB8D8C250B8BB02AF3065FA091E865813E01D83780A163EF399CFD8FFB3AC90D8175FCC1F83577032C3E11BDFF8861B2E629F08F0E94F7F7A74D45147E9FF2CCB28988506D3D035B0C414BCC292191EF81078E18517DC63223616C24EE33BDFF98E0DCB3274F9EC673F1B77EF0AB484D62B1899E5E02B5FF9CAE8D9679F758F092C2F6DB960B877C30D37D8B02C43125AFED81E9C96FDECB3CF2EF00A416679F9DEF7BEE7865BE24680DD8CA229DE2C7D15D688C7165FBC50BEFA9B366D725F7866B578E08107DC704BDC0860C579D55557D9B02C7D132DF9641E9E86002710DECBCDAC36980AFFF0873F748F59629D00065D5C6BC2B2F44182FFB7C997DEBEC4679E79A6808D2672839011975E7A695126BC6316CA95457B21F077E811645994685C464BCDFAF9F8E5C5D0501C387060E69C70667598372B006C804219B3B053118E47F93B94C12C5D0B5DFCF14FB19CD67B71F378EBADB746975F7EB97B2CB31AA020666F43EF98E5E31FFFF8A4F28BDB6FBF7D622310CA6296AE24EC1557D064AE9E1563870F1F768F655603CA00E37AEF98E5631FFBD8A4CC416C2390F72FEC48BEFBDDEF4E323DD54616CF3DF75CA92F416639E1FD7BE1316C8FA6B207175C70C128EC645C10CA669696A5C86C9C68782FA92EBCBC692EA633CB0F3D012F3CE6D8638F9D5478A0F7A0E168204B8B5264324B36BD97938269CB4733CBCD1B6FBCE1867BB0E188CA22D078C8F62458996669418A0CEE62679B790B4732CBC98F7EF42337DC235E3FC2D6E5DA55392C27CE92508A8CED6A7B6AFCC9E51982D563CF9E3D857D80772C8635252A97C0DE8477DE79E7445988DBB7F16F96045264A80C30BA62DFBE7DA50B43667978E59557DC708F785119FFD30898DE419686526464D7955F6034E48567969B2A4340955141CF8019251396A58EC80EFBCC33CF7433BE2B98EBF5C233CB4B95861F3B14CAA965CB962DC5D263FE0EE5384B159177165A532FD3BB84AF0173BDDEB1CCF2820F002FDC231E0A6026CC50408D03CBCEC7BF59CAC831C71C53645A9F76B9DDBF7FBF1B9E595ED87D193B7FEF98073E0328B7023D008D80FECFDB93971055FE4F7DEA536E262F126F0BEACC7253F59DC7E6C27813BAF1C61B6D58966962E755376FDEEC82E9A597F15DF1FDEF7FDF0DCF2C270F3FFCF0E8EAABAF768F796CDBB6CD56F602960C67976273444B2BCBD285319007058217EA1DCB2C27F37C08C684F9FF355C77DD75934620F412B248585535FEA90C2E9ABC17D036653CC964968BBBEFBEDB0D9F8657A66FBEF9E6897D40D887204B904926A178B1D863D3F05E409BB0863C3702AB455525B0DD8A5CE5982FBF2DD341DFB5F25264061A5234A6D3A0F564C515E696BA46D0DA7A2FA14D1E7BEC31373CB3BCDC75D75D6EF834305E53F9545965AD008E44F83B3813595D41A137FE29C6D45EA59F064A19AEB3E00BD07B096D326DE7D9CC728269B8173E0BDCD4513EAD4721CAF0B7BFFDEDE2EF556F040A775E748BE24A3E0F565EB16D137108C657DE4B688BDC0B583DEACC02A97C4A39488F80322C23A16BAEB986DF9593E2E1E38A5D95134F3CB1884730AEF25E425B302BE085679613560B7AE1B3504F97B289072BFE96A5A0CA6DD00DAC8C140FCDBC7E5CA1EB101B5FE0ACC17B116D8076387B185E2D1E7CF041377C16C71D775C51366D5965C150A4E85E1929C63E5E65AE8B2C0805632EEF45B4C14F7FFA53373CB39C3CF4D043B56C41543683497081CAAFFE1FB3F4523C284A104B1D3D404CBC8B4B573BFBB2CD5419AFB299E5A1CCD66231F8B0A45C621E8C0299BFA503232C94DBE59559D67E2846A41CA98BA6572CDE8B68833C23B05AECDCB9D30D9F87CAA5752CAA726FF6225C5A291E1C4D6A8C9D2B65F1445CB9CBA25656A024F45E446A700A49D7D03B96594EEA34FA721CCA1018E7B32AA70C0BD025E9FF314B27C583E15CE391471E71D1DC286037ED55F032B04E40F100D385DECB484D6E00568BBAD3C0EC504DB964C88AFE48E5944640362EE143B654527C8DBD8A6F61D104E742939E80E20032DA7B11A9A1052FB3F77C6679A8BB445C6573FBF6EDC57E95FA9FB26B86CACB2198F0A2A5F72ABC87F5A786279EB87297E1FAEBAF9FC4015D590ADE77DF7D6E78663941EF8499BA776C1632024209C850400A6CBEFC94DF65D30714DD70AFB24FC3FA5963681057F032302E571CC05A6DEF65A4265B08AE1675A781AD4D00655E7A303E98D192E2C14B312E8F2BF93CEC587EDE62A169C43BB8A4DE4ECC83691D4C95BD6399E5835E5F15A72116954BB6A5A3CCEB7F746566DF81C1CB9A8A2DED27DD1E146740983D479C71C619934CA1BBE555F279E87AE86A285075E55866D83CFAE8A36EF83C342B00D481134E3861F23F65972142F87FD0B2A652DBE90FC1421E606B267B2E9C7EFAE9C539341871E52E433C14E862D1102EA19F7AEA29F75866F9686207A24A8E276CCABB7620468F25ABC121FB0E28D6F0C7951A6808F85282B503F0660BE407809D7ABC4A3E0FAE53FCE0BD88D43014F0C233CB09DA7C2FBC0C61597051D6B18B5139A51130DE860729531B8018EB3289AE7F7C9C7060BCE555F259DC7AEBAD93EB8156D77B11A9C99E833265B00D00E8CB8F0311CAAF29BB83933595B80C6A04CE3FFFFC35E14C09120E71052F833534822E7C0AA20CCC8D40A60C9449CA8ACA7BF01B58CC0A0C79ABB13595B82CDA1908DF6A36FCBCF3CE2BC2D1907A957C1EF18EAEDE8B480D0D8F179EC958288FB601B8E28A2B26E594B2ABDD87588938FE1D841415CE56E02AC81822361F56CB78D14517ADABE065E05A0B8D8CF74252F2E4934FBAE1998CA02CDA0600A4FB42914DD955EF78CC20A4510300C40178DEF1C26FB9E59675157C1EE81A74BDF05E484AD85F30DB0664A6A1456CDE2C98AC04D10B44EB5C7A2FEB1EA62A76D3456B2B602D05EBF81288F501F426BC1793922A5B4E67568B580968D1E2217C4E5076CF3AEB2C95DBDE8BFB40559167551607D970F95743591857F079D06870ADC57B3129C136E0B9E79E738F65569B590D00A88CA20C8C66B47A2DEEC3D481B8806E9017CEAA2AAFA2CF42532D02AF2CDECB49C98E1D3BDCF0CC6A43F9C398C8966D8B6C03F0A741D9D59E036CA23BFEEDADB80F5307EBED87BF15CEF25B85C715BC0C7C95753D74311478EDB5D7DCF0CC6A224BC0590D00C80D3E064794DD0D1B36A8DCF656DC07A98B3657640C64C335478A1D755CC1E7C150C0D85B17782F2925975F7E79761E92293095784D99F6B03B0C5376A30D727A29EE8334414B28CF3DF7DC35E16A1D691CE24A5E068DC1009D83F7B252B26BD72E373CB33A5845368E456C799E86EC60584444B9D5C72FC4D53B711FA229F2A01ACF99120678E6892BF83CB00AD4F58062D17B69A9A017900D8456177C53A8ACE14FC096E379E83A79CC527D083E057B25EE033485DD79893B8E9F693685C715BC0CB1D7625A59EFE5A522BB125F3DECF25FA0476BCB701954FEEDEC9789B357E23E400A50D6113F5D201B7EEDB5D716E1D80FD8CA5D86786A90EE96F7125372E4C811373CB37C50616DF99AE603A30C8A436557F5A16FFB0CBA894F011A53E28FEF81724DE1B6729725DE61085D83F732534183458BEE1DCB2C079421DBBBACE21F731A2AFF98CBABEC2AFE31BD91C6A6C0B32073B9076BFD6DB8FCAB6FDCB8714DE52E0BD70A5E56FC4253F3ECB3CFBAE199E1C25E80DA0FD052A7CB3F8DAD5BB7167132954DB9D5F0226C45DE0B69B50100EE014C9178E175160C3136D7F540467B2F3915F894E3257AC732C3E1A4934E9A2C5413F4EEB4904761B69C36013F828A53655766C3637A21AD3700B2E663EACE86CB720AA7A0CA9C2AC40A41B678F65E7A2AB25DC030A1DCD92F3D5F7874475E9992929A6EBB2DAB4D90A72B1609710FE9C002BD1037E129A1E5E53E7CED6DB87C09723C7E1965E05AD1F6EE424F3CF144EE050C046C4D6CA5C7871F1F3AAF0CC5302CE59A785D4B13940EDD438D02CBDCC7BF0B1737D1A9E13E4077DA0BB72FA12C9B376F9E5C0FACCDF60A442AE8CD78E199C5C2525D1479B62C30F78EEF4AAFDCCC828AAF386C396D8236C1617D80EEA37B8C59B8B8894E0D6BEDB9576C21883311C2E99AD91751166B21082C3AF20A490A5E7EF9E53C23D013E84D6A6A4DE0A50ABC7252053502ACF3B765B509C14BD0E41EF2841DA61E172AADEB0104F7025A6C855917E4F6259425DE72BC6D67A24D3CCB66D21037FA54263E245EF9A883B537B1E5B709DA64F4ECB3CF9EDC47F708CBE61726A5BD02374573A328F06CB8328317ABCCA9025D3DAE175BB66C710B4E0AF24AC1C580AB2DBB280C7F7C754CCACBA21E2B65D296D526A043B27601529007FF9A0B93CE1A00D0020BF656B3E15A3945E5B52FA20CC1BA6A42DB1B8BA0C9F5C233E96048A80D3804CA334DD97581EE5B752DC034EEBFFFFE223E3BF5CDEC15616125E142A4509878096E0BEE0936EC81071E28C2EAEE2E24EDAD60DAC52B5829C89B8BB6033EF66D6F8EAF2F3A9D3ACE64E6F1CC33CF8CF6EEDD5BCCEE78C7C13AA429BB1A701E944B390D01AB741CD3BDC8A886EE9497E0369025203BAAD870D96263DD675F4459AC9107D6565E214B0136017C89BC63996AB026848AAFF74617999578DEFB6DCAEEDDBB477BF6EC193DFDF4D39330BECAEC1B68CFB3C89A8F21872DAB75917190EDC968B8B1480BC122015E82DB428E16C8001BAEB42873AA201F84A2CD9D86EFBDF75E373C331BBABC28C2EC7BA2D26313E2BDD3A6A064A6D23FFFFCF3EE71A011A051F78E592573AA5E00362BF114A569041722C5CD53DA41CF43D37F60C3F12140188A429B4165A130295EF00A610AF6EDDB578C49BD6399B5D030C72BEDF8DA81F70E9B82EB6EBEF2BFFAD5AFDCE31EB31A08BB23B02DAB7591C76BC6FDBA877AC5C168AE73993C202DA197E8365046C44A483502F62554C13E4F9BC641BC402F3C7349316EB71E7500FD8E358649C9DD77DF3D3A70E0C0E8D7BFFEB57BBC0CAFBEFAAA1B0EF2FD7FCF3DF7AC29AB75213E7A02DE3DC6742E9397C4548B97E036D0DC683CD522DB80BABA00362ED5F310B75740534081F3C2571D769226DFF50E18D3D7D920A60C870E1D2A2A3DCE67195F7BE79485696A2F1CACAB6F5B56EBA2B2CF5A05DD43F6074111DAA914AD919C1A6262EB25BA0DE41F80051A369C21028D917D09658934AB85A19357509B8289275D37EFD82A81EB6BCF4FC375D75DE7BE9F5430767FF0C107DD637579FDF5D7DD70D002B4D89CBD2E4C7DC7B35E6C341AF2B073995446F012DC16780DC218220E271D7C496C0695457ED985577053F0F39FFFDC0D5F76F86004ADF504DE2378EFA32DF6EFDFEF86D7E5AEBBEE1AFDE217BF708F819E352EAB754057415CD67598EE111633752A45A268DDF89B6E5C9CE0B6D0981F7B691BCE7E8384A389B5195416AE156DAD16A4EBB92A8641D85A908F365F316AA1C7E5E57F1730854799F58ED58571BE170E61059FBB47601D9815C170CDDEC3F4603B95A2FB41A2A4B1A560C7096E0B5A5EEE19876B6ACF665059E49259B4651C4437D40B1F3A78B061F804361F99C6BBE9A69BDC3C5F042FBCF0821BDE040C85BC70200FF0671197D53AD0D8101F5EA8E37B849D863B9342F940A2AC3F3FACA1E244B705F78BA722A52CA9DBB5C4E1889E85B8BD82DE1494965EF81041738F99B6F24CE0969DB2E0E5711F6028E685D7859E1D3D50EF18BD63CCCF6D396D02798B119BBD87B142EC4C260D00F055230C455C13EFA8559097A0385CE6A168496D2695219E8AA247E115FC5586293B6D7F2D1883B6354FDF06E802980AF48E95855904148B2CF862E9B7770EC8E2342EA77521DDC467ED020093611A9BF1B1CE644DC2C2CD933EEC3C50FAF1D58EC34943DDB1A6165C008D895709560DC6B2547CE50B90F72CC0F1F27008CC32E99D05159F5E6F59C3A1D40D007879BF905E804D945DAB4F77C81E6B0B2921E370694CEB8C3DEDA20EC0ECD2AB14ABC099679E594C3DD9C61D4BB73E8DE9EB42B79D32EB1DF3A04CBFF9E69BC5389CDEA7778E07BD62A6A9E332DA04E9C0E27BE91D8DE944D625AC0DE708F3E05E2840E270E661EB6C300A765A900AE0558E65054FB456170234828C63BDBC1A32B39477804E89EE3D435C669FBC73E641FEA552025A8837D60598B5089D88BB1E40565DAC8C8A8FB581A605E370192ADD7CF3CD6B32A92CD68720ABD0BCCAB22CF0ACACB6D4F3026B1796B1D2C7ECDCB9735D18569B2CE39E65ED5706193CB5D100480716DFD3B8C16F5DA62E085223D0D55A017CEF71CF389CC53E75EDC92397CC4525F12ACF50419B1C6FA28AFE43FBD52F1B68FE9F7AEAA97576006CE4C22FC7580908F6785DEC6AD3B85CA6605A0300D4058669E3E3AD8B9BB8B61F3E46568998DBC6C708C787BB9751F3908B72C1949757998602DDFB305F3C8171FEB2567A8B95F8981A819468B10ECE6BE2329982590D805942DDBAB8890315B4AE9C87B046DC9B86A497423ABC8C9A87BCB1CA090360F8E455AEBEC2E21ABBEC99E93AC6F4DEF32E33922ACB7EAB820E8CC654798D35A42D8B2999D50040E885B72EC518DC4B20682890CA4FDA2C640AEC2DBE209C2EBD9751F3D0C60CD62741DFED03E8CA5BCD3D8D31AEDCBCE75B150E1E3C383A7CF8B07BAC29E89BEC76F64CD1C5653035CC5651BFBCF480597BD1AA149A482F81A03950F08EA7469680F134A48C83BC8C9A876636D841C64E117A156F91C4464C82F4D7318ACACCC7ACC62BE8D2108EFBC5B30031215DADCACC0600B050E23CE65DBDE32921F37909710BAC9982BABD00ECDC19D31197661780A946AF3276055F7A2D3BB590C65CE9DB8132144F93D2EBC42AD096B936911D00AEE6BC340AB3ECBA5571132976ECD831C928EF786A3417CADCAD0DA74B54D75C55DE88A874C465870374C38837AE9C6D810E22DEAA9AB5E2ABA0C85B14E880E2958D9401CAB62D635D415ACA0CE98CEEAA5529CC44BD840A75C1E9467BC753C3F837DE562C4C8B144A492FB3E6C10C406C768CF757E2047A1E5E854D010E50E21909A63EE355619974D0A0525E6D9EF3F5E76360CB40D7284D28B7BD74C784B4B72AAE255E0C2D16E77A4ABA36E05EB18292E10AD35E5E46958138639F844C41C676F2B86EF22A72158843331882AF3F15DF4B5BA639547ABB1604D8A1474BDF178D166151DFBCF47B84E7684FB4859197600BE78D4F2FF08EA746D390364C5652756DD9B523918D53A080C48780B5A8636D3C0D8E882BB93DA66B8CF6B6E87110070A3E2F3D99E660ED68ACE70A788F9E4DC922A1BC9036CA7515B364F35CAD8A9BE818BE9E9C1B7BF3690BEE15F738509AD9ED96AA429C8CC16C9C31142A7A1B0C0B38BF0C8CEB356BC290C9BB774A9A9AB90E1DDE91CD7FAC22FB56E9419B83001F0AEF596661A6835B9589967C1E4A50AA8D1366A10A15871356D76988142B719CB3E00B0368652DE82958DFADF36478C474A377EFA6603C824F7B56B5F13FF6EEF139CB0CEB42AC2E8577D095A15A1DB44D38E9FCE52F7FE93ED33C5407C6B42AA51B00B98CA221F08EA78446867B51F06D3876FDB38C286621BB00ACE96C9CA9206EBAA0DEBD9B70E4C89162FA08CDB5C2EA16AAA1C1B0CA1A4641171FA026D8F47ACF5496AE1A00C47D100FCC7639BF0B8D2A7608F1A225D905D4DD3D560B856C9CA9906F42EFBE55C15B0D4ACA6963466D5CE11D1B3A0CA3E21D8379DEAE7C55D401FD115F7BA5977AD2D4F78279FED6C57D280F193254B9A609DC877BDA30ECB4EBDA0500714E5B0DD914E2AEBB8A91CD2F30884229E91D8F61DB322F7C88F04EE39D9FD964A4AB55A975605C6FED3A587A5EF7C3E461F2A27529BAD5DE437AC899240FEC1D4F89EC106C98766FA9BBE65DB6DF36CE5468ECE7DDD7031F77BB76EDAAEDEC926BBDF021404319CFD7A3A7E973171F25B49DE2A50E606DEA3D5F534CBEB42BCC9556B585D694192FCC3B9E12EE4386D830EE4FE6C7995616E2648C65E34C057153B0BDFB027BD583DDBEBA2EA937CC681B2A107A12F208182FE3B7D0CBC7BE80B2510D3B3023D686AEC7A2A9C340275279E51FD70076CDDEF154C894D386695E3FF6B05A162D06B171A642B30DDE7D5F7CF14537BC0934265E785FC0EAD27A2396B3172FEFFA02BDCC78EBB9B6B636F7B0FA84319D4871332F33A621238C79E6C429E03EB183460C2B988EF332B00CC459C612B20E2830D9BC34BE274A3D169FC4E14DD8BD7B77315BE21D5B14CCCB5BCB3C2A7D5BB32FA9605A57AEBB05BAA6BA26E84DB06918D3BEC8DCB7EA92484D79A001F78EA7428648364CCB68EB6E29A6163E5E7C9402E91968B4E2FBCEF2455F9754EEB09AC057D3567AF44A186F79F9D317E4345469061AAB456E83A6A5EBC618AD33A93CD522671E6DDB06C875189963C3E540C3CBC8321067593B88AA10B7A7A7A8620E5A96BD7BF7BAE15DC03A07EBB908A8587D9EB6C3CA948D6A6D9A99DAA611F39EB14B941EA36CEC46A8486C01ED65D82C58F136BEBCF0C0E31D4F850C916C985AEFBA0B6DB45CD8C6990ABA8EC4EDDD174DB717DE842E1B012ABD5DFB00749F791F5E5EF401D2C730C4A699ADCD19AE78CFB808E48F908668210DC0F8C7CDBC79701DD0F5F58EA7827BD03DB36138526CB2D30D71569906AD027133BF1DDF13DB8659DB535701B360CC84B99F773C1528F2E8D1E85DEB5DB4AD046E02F6F8F11E880C57D1EA7BCFB8486CDEAA671DE8548AC5265E66CE8207E0DA798B6D9AA279631B264722755FAAC65C6DF83F949EC1BB6F53ED3DD388C481F75AEF780AE2693BE5736CA2DD274877348D563C074AEBF8F9FA82D91864327432E9EF4EBCA5B865D9B06143712D99ED1D4F05F7881782D0F0707F2F73CB409C759F7B1EC44BFAE27BD225F536B79805863F74F5DB9CFF673885718BF20478A7323FEE2B4CBF1AB7DAC554E3107C30D8CA8F4E8B6731EB00A03B9127DDBAD6585C0B6DFA115497CE8649EB5E77CA462FA10DC595F40CDE7DC9272FDC42CF84E102A6C2DEF114B050CA1ABB00A6AE5DFACBAB03E6C25474A599D9ACB62CF3DAC0E6390BDDF45C0B6B0082D456E6A054E17AF08EA702AD336EB56C18BD1732D1CBE832A007682BDDC43B6DFDC2DB6FBFBD2E0C2D3546432C0A8A8FA582464F8A4A8185651BD3A229A127B265CB96499AD1E66393EF3D639FB1FB1060F2AEE743A7A2F040B7A2050E36D3AB204B38C68EDEF114C8B2CC8EDBE5E78F82ED657819B8BE8E0E641E7246EA35022804F94561052CFFA590C7E7A5802FBD758C0A287FDB9A0A4D053D52AB24A3B16E32FDBB28BCFC8F9F55C37043B7D2B401B01A4C8D69DA80F8E3B50884D55D8D07142ACC306D9C29A0002B4FBCDD7DB47D755B151F2858D61539DD65B663F7D2DB17A8F43252133807F10CACFA4E9CFFE06D3FA6639D4F0346D2C809280F461C3CB4773C05B23AB3611A53792FA00C7237D5C6BE703266EAF2CB45D7D22E5965DBF545B9C42E0BC3B8786930EFA52D6F4B6D42375F2B5ACBE4BFACFF18828769F9C508B6EC8CB3BC4496451B8DC62EB95342FC547A1B86910AF7F45E4819E80EA34DB671A642FE14B88777EF14B006C1163A7A1CF1AC49DF604D0728CD8042BA0F96795561A11AEFC03E4B99FC97411D8D1DFF876B172A8DBF849A436ECB6923D353C46FC354C9EAFADE579C6DE802406B1868046824BD34548546CF5AB931EDD8F6FA8CA650C1E3E9467A7543ECDE53E97907F659C8FFD868CD837CB09EB7233B80C50963618C27E20457419511DA722346DC716167F1105F41EF659581EE174A451B674A5062AA7144A14501F0D2310BE6B86DA5C78C9B78BDFBF5051A553B53C4B3CFF29DD07778075AAE0EE47F99AF3DC3419B0F824644E784B0C5890C7B6CC2EB60DD237BC79B22AB2F1BC6FC3061D807782F6E1ED238B761176061CA4D7E16813123C4331914161DD3B9C0AC0269F5E2EE0B547A6BEC029E227428F00E6CA5475957768815E7C3AC7717CE59B8145F712F8155D0D4879DEF4C0971C78B91504036B10EE4EBC418D4C6D9164C67C68E30A7C179F126AA7D832F1C464436DD68F3E9997979DD77703C63F52A94ADB2EF807CB0F6165C47A3EF9D6B09E72F56BC157875211E68A3119005A30D53A67B2FB40CB2C6B2717645640956A4C73BAF8FD87483B7186A48C4CFE33DB387ADF455AF85704D2F24492F4073E17C59BDE34DA02B4DDCF1B81D3B8126D36EA99E7DD9E1AB66D7D7D3B5ADEBAEAD0FD05BA19CEA79F88A97358F272FE821D86BEBD85B84EB172F74DB18B37989AC8AE6D9A994DEF126A08061FAD286C91EA1AE13471963D83833EF4225B73D15A6BE181F7BF9D877189B53C6ED96707CC109F79E3D061D8D31DC296C199AAC9834F9BA78D10A2B2FA175902FC1D4DE60E5CF2D56C830ED468BECBDF8321027BF36CE558546962F1C79020C1187B0E26E1A9E5B722AB3F7EC312898C90F5D4B5C65AF9D47AF1A80208522CF4B6C55F45586D888A7291448147F360CF35AEE5567AA0DB0DEE27A1BE72AC1146BBC0106D3555E5E0D016C0DB66DDB36791EF447B1027916E487AED5F5657B0A65E95D03202B2D2FB175B08D8077BC2E5A7ACBD4A30DA7616078E015883210275F3A1BE73283018B556231EDE579391E0A54526BA8C36A52CAB4F7EC1EE4859D05E0DAD495DED2C71E0092D49847FEFC52EB03188BC566CC3248AA6B17205F6D7D5F2ADB046CD481E7144D8CA9160D6555EB45804ACF8C84F7EC1E0C296D7E901755AE6F422F1B00D9F67B09AE8B364048393380D93171C695954241785C50CA20B7E4A99F7FD1A09D66D1979E0DD09734DDD87251304C65B5A09E858F0B1A7DEFD93DE8999227363FAA5C9F02DB3B1ED33B2965DF5C16F621204E48E9938FF8585C61C374AF698E39E621B3DB94CFBF28A8F4540EE53DB0DA6E8876F882E7B15377CCFC542953EAE509B4F8753D6335C1A6614CBF04AD27DD132FE17591F61E5299DE4EDB069CB9690A895780E621079F5EBC43807CD69E8E82B12DDBA479CF3B04504EDA3D09289F287DBDE7F7203FAC7B73F2A8CAF5A9891AA1DE4AB2190121E51D8A26EF781D98668C9D7BC860A8EE0214AD53AFB37FC22220CDF8F623CD829997A1CED703E3FA534E3965F23C547AD67E78CFEF81610E3319BA9E9E03D757DD152B35F194E4987E0A050AADBAF7104D50F78D17EA1DAF8A7CAB697DB5603AB0C97A7C7D31662DE45824B89DD29266C1B25BAC24BDE719023C8F75FE09B137A859F055B779829EA3CAF56DC23043FA3530DEA37A2DAD78FE5523906A87196603E8E6D93029795845E815B632685EBC2DC72155214DD6C32C3006AE6BFBD00798768D1B32DE599572479E58631DAE4F6D7BD204EB3E0FA47308FFF7574E3AE9A4A2D58A1F2805E3E80B52E803B41499AFA20D97E6DB2B786591AF3ABB86BB6BD04B585FF8F44A866C990718DAD8713D6EE0AB8CCBC913FB45E53D35F56B518779CA62E9A960EBD6AD6B8E85F0FE8A96F7326561139E023B3EF38E5705BB80D83A10881F278D5E212C8B75F2D895834D1455765C4F7776C8959EC619135A6B87CF9C7B955E20796F95C9E449AAF52B55A03EF02E940E86CAD6B7261F35D2A9A94A7ABC9E6D41B8BEDFC238FACA2BAF5C97F814C8108202E21DAF0A7131976FC364881417C8AAD8AF155D567B8F54A0BC8C1557DCD74BCF50C0D7829E07584D08DEF34F434A5D1B87775E9B50A9E374D098D1F350A3666790747C5A5A4D5CFD16ADECF31EA229F2A00BB498DE3955C0B085D6D686C92EA0C9422121F75E90724F7CB4DDB12B692A0E66A85E3A8600538FB6D1E44342A1AFA2856726C0E60BBA0EE2F0CE6D13D260ED29B44315E1288BED1423307B443A29DF5E7C40790CE70F425A53AA608841FCE01DAF821A94D8FE9B8A446BEC15D4AA580B34A00B0AAC46B4F79C05DD415D67E3C2BA71886EB1051F8BB832546DD819D7C7F992E2E350151489361DD8963CFBECB3230953DA9429350078A8E63C2F2E8FA13500489109DEC334450B30CAB8509A07D360F1D759532E74AFBD825B07EE03C4EBC1D78F292D61B7B9B210C7902B3DD36CD6DF21D015AE6A43421E994A51C4916A96A80AF134E4A38F3E1AAAFC5A79E185178AE3A49977AD1E8217A7C7E01A00A659E2F1754AA40F686A7CA4E9BFB8C7A2A998B6BAD5348EE806841D2E0043131D1B72D75EF07CD66926F95DF503814B77DBC5276F30E0F1CE6D131993291DF44A0F1E3C18AAFA7491CF0B8B17BFC7107B00C8BA25B829217E685A08B42A300E57FC5E81CECC074323594902B6178C87E37C9E053D06501CACE5A0E27BE7B609D373B6F1A132F32C5564DFBE7DC5B5E86B64E5EADDCB63900D00CA2A9C2C780F9402B9FE06EF78158883A9411BC6A211C287DCE5EE1A66806CA567BCCBF4A4CDD77930048B35E4C4D1D6A62CD3C01458AEE40125E3F6EDDB4375AE279B366D2AF267251A80204545F51E2A05CCA9720F7661F18E9745CAC5385C56885E61CFBC0B95D53A0A61AA2BB6B49C07955E5E9A00851971A45C0D5A06EEC733291D80CEE2F0E1C3A10A37939D3B771671AA57E3A5C163B00D80ACEEBC874A85E6559BFA5E230E6F5523E114F2B8E0AF32E82564F825506CC579370F2A3EF1D93852AF2C9D07538D52FC0A14756D895DDDE7A5C7239C3F5829E664BD074B8135B8F08E9785C68AC6240ED70B1BAA438CD4F03552CF08180B57B5FE6458651569F8586CC382741EA4C17C5D8B21CBABAFBE1AAA6A3BC27D75BF383DD308E70F53E81EC64B7053836DF8F856EBC6F155210E0A840D532F0656B52780D9B4ADF4F4B6EA2878ED925D208E361690CD82DE8B4D07B3554F3FFD74A89EDD08F76556C44B9F4748EBA0A550A2780F970AB9E86AB2A453A6C071B8554A7915641941BF221D0BE02F00472171DECC239E02240E2AA1776E9BC453AD74FB1725D20578E9F408691EBCB80F9712EE015AE9C7D003D0BAC6E74E83EBE9F6C7E1DA8413231DAFC22C03AC62B4EEB101E3A3AAAB3099EA22DF15073D08E2F1CE6D13D2601B317A1CD38C75BA16D253D65626A47FF05274BDBC074C85ECAE21F67A73DA69A795FAF230DDC4F99E5251F6EA43F6811F43E368D7C7A388ABD35B236FED725668BBD7E781D75EBC48290D3400F40AFB264F3CF144913EEF1962C2B32C8514E375EF215381A108F781A38F3F7EF477C6611FFAC427266165C69C3AD79B869252107B7EE689BD4AD577A8F44C9DEA3979262A4AFCAC65603680C65571114F5B66E0D3E09DDA59097A1C343E7D17D25A4617109E6B29A47898B635BEB2DAA2F2C399C69AACCCFD650A0CDE8A34BBDA8B82E755B2BE81E69D8AA974034AD33A1E8CD095D8C52F28799925F1CE6D93D87D39696291D75064EFDEBD45BABD671366DA7069A4B27558556425A80600F8DF326FA9A93DD73B2EA52360A7EE55BA3E803EC43E0BE06CD27BA659905F10C7E59DDB26A4215E0148F85085F4B3C02D7E4EB1940D0054D986A92AD31A8093C6F7546F605E9797822623A36966A8B611C002CEAB808B82A1905C9401CABDBAEB26D8FCD34E033284408BEE9DDB16E88FEC26A4F0E28B2F866A345C79FCF1C78BBCF59E1996B101405AF5D4E235005B7EEFF72661FC429975F93A77DAB081F1A7CEC13128DA6EAF427601953EFE3AD69D726339B4F538C4F06111D377A4C1363E7BF6EC19BDF1C61BA1FA0C5F78169E6BDA0771291B008D45CB4E8354452BFCB6DE78E3A401E07F7A00FCFDA530DF5FC64049330BF31636316B20651876EC0C73BC4A9A1A1AB178C683B4D431B06136209E2F6F6A625D073B2B01B8737FEBADB74295593EE13D32C3E4E54568FC96528A97CBD491F7E04D21EED32FBDB4A8F07FCB6910680C082BA38595B928ABC1BCE316BAC7D6D20C6D34C415B729C429CF32C06EB7347C5E9A66814F0474188A872F4E95ADB153411AEC0A4F94ABB00A82F931CFEC2D6A0BF9B1B4528CEBE2874E018598F8A9EC1AF7ABF20BC2C0BB3E465DB12A7EE658BFAE7B08D2055EA59E85AEB336F4E831EABAC0B22BF820DE37B10B1856D9C687AF204B8A5751F01C1C0F8BCD3B5A4E91C1C62C2D685D6494B2FDFEFB8BDFDF187F31E306E0B7C6158B63DEF51E9C0BB31C384E83E18E551AC6E023CF22CBC318C6F875874E3424F8D8575CC44377DB3BB72D50A8920EA58142CFB063D5E5D0A143457E289FAC127ACC524BF1906DD80610EFA77FFBB78BDF8D175FBCAE01008E956D806CD7BEA9CF7FBAEF16C56B418BAFE375EF874D83F547880D03F179E7B689DCAF0956DEF1D5CBF25742BE30DCB4D3ADE4D3F877E9A5F14A3E0FEB87CDABFCC0B12A3D10392505C6A8DE3975605A2D8682E09D5B162A7B5022151067D74E3618D75AC329ECF3DF7EFBED50E4B35891F3506B88366625A478D8149E7E2DB2EBFFCDDFF91DB7F2831484DEF5D3B0DE6B163135360BC6D4768D3B5DFCB62D2F6318C7B3C65F6980E79F7F3E14F32CD3E4C891236BF26CCC4A49F1D05E81AA0B4B4F89F3A21FFCC0ADFCF0BB617F80AA6361EB2760F3E6CDEE395DC1B89E34283D3C0B2BF2BC73DB8434689354D8B56B57AEF8154579376625A5E82E7A85AB0E52787915DFC239758720D66B6DD71E6BEDC227202DF837F4CE6D0BEE49DE290DF440ECA61859AA09B33A212F574FD8ED66FC33D334B22AC4376B08009CD3540761E7B0F17B5FC7634E19885BFB2200F7EDDAAB0EC651A443694099C762A02C69843C0D7A93D513EDA48A171EAFF055856DCBFFE6A64D6EC517DC2F951252EEC9040E4478963A463A02E322EB9588F9FFB697557BD834007609FBF7EF0FC5364B2A79F3CD3795C72B2B4506A4F88AEA4B75C2D967BB95FF6FFFC99F14C7537BA3A56BCC9CBDFD5A0BBA79B3F056F001F179F76A13D26337C56025E173CF3D178A6A963604B3E790DF2B2D4526349D0A03B3A062F489F117F9771F7C7082C2817977EFFA14D06DC6E805EC3DA7A173A1EB4D31ACA765903D4296EEC4D886ACAC1419306D91441598FFB6DB8BC7B078477FB7618F10435AE6E15DD73618EBC8ED9960B5DA3BEFBC138A6596AEC44C09AEAEC88024A5A9305F37946616C26924B817C4D72C33CC1AB047BD9E1DB216BF1F628CB85657F445EAA21B2CB7E0296721FA0AAEC0EC56DD8F3DF658316F9FA53FC23B09EF67E5A5C8882E1A01BB3A2D85FEA14F301381124FCF8752919E4F96FE0AFAABE093627505ABB6F14F41178DC085175E38B95FD7B6F3A9418B6F5716E2FF8065A659862166EA75B5C516E22A6BF2EB62BDEC5061BC73FA0CB6034A3FB05F3FFA8E2CC393F00EB3E0FE6AFC535075B79A3A6044A435D92957FEB545BCE4167F7AB9D20F5F8E3DF658BDD32C28AFC63F055E256803DD0F8D791FF5028CE3AD2F3F664FB22C8FE4062012AD7CD31E806DC3725AEE07F1EEC17DC0AEB7571AB32C8FC867E0982C468A4CC1BD9457295283324DD659D825C87EA00F90262A3D464CF29D8F9E24CBF24828EF59222932A6AD95771EF818D0F257C6D8340CDE795DA1693D5C4709A68E5830946579C458AB6689A4C898AE2B2273B36A08CE39E79C853404F8EC270D184BD906404382DDBB7787E29365E862F641CCE2489139B8EAF22A4A9B303D69B7ACC21B715B7B1D00715BAF3B80920877E1561780910FFB182C44FEFCDF8E46BF78602D591A4B78B75962B16EA631E7F52A4EDBE079976EB7D2016CF7C4F461DD86499B63808D17631EEE15AF2CA49B4838D7CAB9CAC1830743F16959FECBBF1C8DEE78CF7C1E3C7734FAEFFF215C94A58A04B3F82C9E5867155D180ACD83AEF9ACA5BF74E9626C4316437C60EFA106270E17DC1FBF04ADCAFF7CC1AFE8F3F8F1B6D1E82FFE5B88244B19A1E10FE5218B27DA0C04FA345F4F25C4A0C8A274C6D873E69921AB01F08E817C22B6B69CF7A10BFCCA5D85FFF77F436459CA48282759A6097EE8C73F85171BAF52F405B6EA8EA93A7C99D700007EF85BB10BF8D9A57E85AECA8EF78F46FFE4C210699679C2FBA69C679921FAF2A12CF32AC5B250A601D012E7A426C1778D1B14AF32BFB8C70F2FC3A3ABB9276055315BB6679925722E9AD29948DF28D30000CA48B6354B227FF0E1F595F7E7DF0807833CFBE0FA73CAB0FB8610419669921B800AA27DE6376CD8E0568CA153B601D02626389868247FF49B7EC59D267BBEE39F3F8B2C73857739264B19C12DF7F8A76839BDCA3164CA3600400F60DBB66DA108D514AFC23EF45BE1E00C79EC2AFF5A8F3FFC68B828CB34C1D374981ACE5246347DC276E45EE5182A551A00F907A8BD55D70F3EE957D897F6851382BCF94AF82392833B47A3FB36FA71C4649929FAA88DC95256B49007471F5E051922551A00C02EA0B675A05751C1CAAF0FBF1BF6AFC65DFFB7FF2204464243C0573E8EC7F2DDBF1E4ECE324D78EF94EB2CD5A4C8387C0A78156468546D00F06CC4F9B5C4ABA8872227A28FFFDDBF3AF6FB7F6D34DA737B38100973FF5C6BE38AC932534259CE52432A559A3E53B50100CEC73D582599F6C5C6FCD7CA1FFC8DF5E7DCFD91D1E8A9DF0F274472E42FD79F2FB2CC14568132C34581CE525D7AE9D8A32A751A00994C5792690D402CDE39021D8227AFFC7BFF7C7A1059D649B42374963A12DC2C172BE8BC4A32147806947BDEB15970DD05175C108A5409F12AE8BFF807E160100C79BCF360FF0FC3498EFCAFFFEA5F931B8089B0EC3B5A5792A5A9C85A30F5A6A05D42FAEB34009A11282D5E057DE9DF848341BC739EB8391C9C21BBFEBE7FED8A3700F897B06B46F86885F7962595F0151CFF14EBE9BD8AD277487B9D06800D42B8F6C9279F0CC56D8E7815D4CACB7FBAFEF85377868353E4B947DE3D27BE4EAC6003C0BB61DF0BDE0D5C76D96505E3BFB3B42532ADC4E36F5C51FA0EE9AED300009E83F0245C4AA88CB672326E977863F87B4E0C071D9936E68F59910680ADC059B9CABB049CBA04CFD7593A9422F3FBE047A00AA4B96E03202723A5245602A2FD7FE09CB561967F7D47B8D091838F4F5F4C6459E206E0EDB7DF1EBDFEFAEB45FE03953EB8FECEB240295E865759FA0AE9ADDB00E06B80EBCF3FFFFC502C67C83CC31D8F7D7F182E76E49D23A3D19FFD73FF3A31CD9068E0C2EC93DD823D3875CDD21319D4F420E9ADDB0000D763563A57FEC77FF22BE93CFED1C746A33FFD7E88C491FFF3BF47A303FFD4BF768984C6163374F21B6874C7BF597A28C50B62D18C5761FA0669ADDB00E01FE0B4D34E2BE228B559A85749CB72EF6F8C46FFEE1F87881CF9B37FB6FE9A810BBB356949BA21CB006474D451478D2EBEF862B7E2F409D25AB501C00AD06EAF062842E7CAB4C5405598B7DE1FD361CEFB87478780E1C90D37DCB0660BF6315906289317D8E7EDC1495F990600D7E576EF40DC98E3A79063843323305758E01357E8BA3CF34721D220FC2FDF013B3E10028723F7DE7BAF5DA1373AEFBCF3F8CD325461C5DCF867425FB707276DD31A005C91E30948CF809699421A9F47E1E578299B00BECC71656E022B03E330148E03907DFBF68D76EEDC39C95FBEFA975C72097F67591299BC5CC1B82EAE408B8434D90680EDC1B167507A31759EE7124DE7735E29C189675C69537167BF7735668F8503070E4CF217C27A8C2C4B2A6B5E3674B90FE13C480F0DC0C30F3FBC268DEC0D78E59557BAD700C39AF81A28257F7CB65F7953D053C158876192F229D8E567597689B7DD167D5944445A707FAE74E1129DADCCBD730569B7D770BEB63F2F2D3F3CC3AFC04DF8CBD743E4FD112ABDDDF66D4C9655135B59F8DACAC1262CC2D9284A3BEEAB34C0BC5E099A697BCDA9A79EBAEE1AC2D95AACB4FCF9337E45AEC3ABFF3144BA78397CF8F0BA59923159565C268561F3E6CD4585619B708551296D656A03ABC507EE3FEF6BEF5DE39D076C4DC63995A4C93E00808FC0FFBCF81D8C5F7EF9E5C92E4A90F7E0CBB246E2DD78819D7CA8386C0AAA3076E181B872D541716193A0F8B9D7BC4ACF35F66BCF35B7DD769B7B2EB07108D7E87C660B2ACBDEBBFC0A3E0D2AFE819F868B1727B7DC72CBE4B90359B2F88289F0F8670D4C17AA226969B1A01BC95E856594862C42E25C1477360E606F03E2F6AE132CECB1FB22D200CCBB86F3ADA59AEE8F82ABB6ECFC7BEF32ADD2736C9673900E8499123984D173DF71C71DFC9D25CB6C913E800A162BD26CE5626A881D7B75BC0A5C0B36BE69C4DB86CFBB8EC26FAFC15372A80C564255591E79E9A5970A3D08CF0628F62EBCF0C2F8B9B36429254521C226C056F2ABAEBA6AF4D0430FADAB747C61B4B5F734A457280363F5E00CB280EB6FBDF556F75CC13576A8128608D3A4592FA027C272DB43870E4D9E99D98F39CF9D25CB7CD9B469D3A450690BF2AD5BB74EC230BB4DBD3539F159A711DA3EDC3B57C4D7A04B083B27CF14CEA3773354612BF4F163AC79EEA0B0CD92258D6869A7B507C09593B4EE54201A025B21EB8252CEFA86436937CF22118DB65D733EA6AA84EA341CA192DB9ED1CD37DF5CE7B9B36429276A04625B7C6CEBE3E9B7D34F3F7DC2A5975EBAE67CA08B6ECF11BA9EC28CA22ABE2EC65E73CD35D7F05B570AE563DF85717D585B6FC992A533290A1D4E36E3CA885757146C56E35C05BEFA5C1BC71B43B73E9AA64C2145D7B9AFC233A3FB209D812C5916264521C4C186574163587C236FAF16EFDC59708DEE7DF9E5978F6EBFFDF6D4156174E4C89150E5162FF480B4BF23B09CB94865962C3D90625A89EEBF57595371D34D3715FB18703F28A3D46B20857DC22285054BCCAC9016C060A9E567CE92A5BAD805231807A1A8F32A705D82A14A016BFA3B723851DCAF6BD9BB77EF68F7EEDD93E785EC60234BEF050DB4DDBEA96E23C0D41D063B5C6FB5FF41C3DDB58CDE7CF3CD5035DB13861AD8E3733F40FFB0A0E7CD92A59958A59FA7F19F063301147CD0F5864549EB0D004BAEA365D759B22C854C0A35EBCAC1567885813DD78CF1172EAA98A965CF9E3DC5D263E2868D1B37F6E279B364694B2685DD23F818E8AB8CDE78E38D5075EBCBAE5DBBD66C6D9D37C4C8926518327AEDB5D74235AE2E769562204B962C43112D83AE2218416149C87580B5247165C992656012E6DD0BC798B3E4E9A79F5E53E9599A8C81127164C99265D8524CD3C5829BECFDFBF74F2AFDC9279F9CB7B6CE9265D9446B0D24E804F85F84E359B26459465103C00AC8C8355A962C59564472C5CF92254B962C59B264E9B9BCE73DFF1FB1734FBF3F2CBE970000000049454E44AE426082;
INSERT INTO [BinaryFileData] ([Id],[Content],[Guid]) VALUES (
							@i_BinaryFile_PrintBlanksIconId
							,@s_ThumbnailData
							,NEWID()
							);

INSERT INTO [AttributeValue] ([IsSystem],[AttributeId],[EntityId],[Value],[Guid]) VALUES (
                            0
							,@i_ExternalApplication_IconAttributeId
							,@i_PrintBlanksDVId
							,@g_BinaryFile_PrintBlanksGuid
							,NEWID()
							);
INSERT INTO [AttributeValue] ([IsSystem],[AttributeId],[EntityId],[Value],[Guid]) VALUES (
							0
							,@i_ExternalApplication_VendorAttributeId
							,@i_PrintBlanksDVId
							,'Christ''s Church of Flagstaff'
							,NEWID()
							);
INSERT INTO [AttributeValue] ([IsSystem],[AttributeId],[EntityId],[Value],[Guid]) VALUES (
							0
							,@i_ExternalApplication_DownloadUrlAttributeId
							,@i_PrintBlanksDVId
							,'https://github.com/mikejed/Rock-Plugins/raw/master/Print%20blank%20labels%20Plugin/v2.1/PrintBlanks2.1.exe'
							,NEWID()
							);