```
connect fivem.azda-me.my.id
```

# Docs Matyr
* ##  [Notify](#matyr_notify).
* ##  [context](#matyr_context).

### matyr_notify
#### export notify
```
local notify = exports['matyr_notify']
```
#### set notify
##### client
```
notify:id('type', 'message')
```
##### server 
```
TriggerClientEvent('matyr_notify:id', source, { type = 'type', text = 'message'})
```

* id = DoShortHudText(1000)','DoHudText(2500)','DoLongHudText(5000)'
* type = 'inform', 'success', 'error', 'warn'

---
### matyr_context
#### export context

```
local context = exports['matyr_context']
```
#### set context
```
    context:openmenu {
        {
            id = 1,
            header = "Main Title",
            txt = ""
        },
        {
            id = 2,
            header = "Sub Menu Button",
            txt = "This goes to a sub menu",
            params = {
                event = "",
                args = {
                    number = 1,
                    id = 2
                }
            }
        },
        {
            id = 3,
            header = "Exit",
            txt = "",
            params = {
                event = "Exit",
            }
        }
    }
```
---
