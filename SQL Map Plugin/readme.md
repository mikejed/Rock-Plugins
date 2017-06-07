## Mapping Rock's database
Rock customizers seem to largely fall into two camps- the developer-type who are quite comfortable with C# and the ways that you can access Rock data that getting into the source code offers, and those of us who use a lot of DynamicData blocks and SQL - often with help from the community. (Which, as I hope you've figured out by now, is a pretty stellar community and an incredible resource).

And while the ModelMap is an incredible tool for the C# folks and Lava relationships, it doesn't quite explain how to JOIN the database tables to get from one entity to another. And guessing at it results in some understandable and easy-to-make mistakes like assuming that a table's [PersonAliasId] column should be joined to the [Person].[Id] column (it shouldn't).

This plugin seeks to help fill that gap for the time being by providing the one-to-one links from table to table. For instance, it will show you that the `[GroupMember].[PersonId]` column should be joined with `[Person].[Id]`, but that `[Attendance].[PersonAliasId]` should be joined with `[PersonAlias].[Id]`

![Screenshot](../SQL%20Map%20Plugin/screenshot.png?raw "Sample database map")

## Attribute Values
There is a limitation though; since this is an automatically-generated list, it *doesn't* show _all_ of the links you'll need. One of the notable missing relationships has to do with getting Attribute Values: since lookups are usually done based on [AttributeValue].[EntityId] and [AttributeValue].[AttributeId] together, there's no one-to-one relationship to match.

Here's an example of how to get the value of the `BaptismDate` attribute for a Person with ID 123:

```
SELECT
    p.[NickName] + ' ' + p.[LastName] AS "Name"
    ,a.[Name]
    ,av.[Value]
FROM
    [Person] p
    LEFT JOIN [AttributeValue] av ON p.[Id]=av.[EntityId]
    LEFT JOIN [Attribute] a ON av.[AttributeId]=a.[Id]
    LEFT JOIN [EntityType] e ON a.[EntityTypeId]=e.[Id]
WHERE
    e.[FriendlyName]='Person'
    AND a.[Key]='BaptismDate'
    AND p.[Id]=123
```

In English, just understand that the AttributeValue's EntityId value points to the ID column in the Person table...but ONLY for person attributes as identified by the Attribute.EntityId column.

If you look at the data used by the above, you should see that usually EntityId=15 is `Rock.Model.Person`, so the AttributeValue you want is the one that identifies the PersonAliasId in [AttributeValue].[EntityId] and corresponds to an attribute where [Attribute].[EntityId]=15

## Installation information
After you install the plugin, you should see a new page under Power Tools (on the Admin menu) called `SQL Map`. Go to that page and your database map should be visible. It's quite long so you can either search (Ctrl+F) for the text you need, or add #Tablename to the end of the address to jump to that table. For instance, http://rock.rocksolidchurchdemo.com/page/123#Person would take you to the `Person` table, if the SQL Map was on page 123 on the demo site.

You can also click on the big blue chain icon to the left of each table heading to get the anchor to that table. And every reference to another column is a link to take you straight to that part of the map.

## More info
I published an article before this plugin, outlining how to create a page very similar to this database map (this plugin has been updated with a few new pieces of useful information though). I encourage you to take a look at [that article](http://shouldertheboulder.com/Article?id=486) if you want to know more.

## Support
You can file a report here if you need help, but I encourage you to jump into the [Rock Slack channel](https://www.rockrms.com/slack) first. You can ping me by mentioning `@mikejed` in there.
