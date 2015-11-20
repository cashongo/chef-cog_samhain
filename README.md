cog_samhain Cookbook
====================
This cookbook installs samhain from source that is included into
cookbook.

When you want to upgrade samhain, add new source as file and
update version in attributes.

Tested on Amazon Linux, should work also on Centos
Requirements
------------

Attributes
----------
#### cog_samhain::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cog_samhain']['version']</tt></td>
    <td>String</td>
    <td>Samhain version number</td>
    <td><tt>"4.1.0"</tt></td>
  </tr>
</table>

Usage
-----
#### cog_samhain::default

Just include `cog_samhain` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[cog_samhain]"
  ]
}
```

#### Things to know

All binary paths and database paths are default, as configure/compile
sets them.

On install it will init samhain database and start samhain.

updating samhain database can be done this way:

    samhain -t update --foreground

And then send HUP to currently running samhain or reload samhain service.

Samhain can monitor growing log files (checksumming to last known file size),
if we use this feature, we should update database rather often.

Currently logs go only to syslog.

Currently there is no way to specify machine specific configuration, there is
just configuration file as a file in files/default directory

In order to rebuild samhain, do ```touch /root/rebuild_samhain```
