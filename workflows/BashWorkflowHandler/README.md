Bash Workflow Handler
=====================

This handler can be included into a Alfred 2 workflow based on bash scripts. It is meant to reduce the overhead when creating feedback XML and dealing with workflow preferences.
 
Installation
------------

[Download](https://raw.github.com/markokaestner/alfred2/master/workflows/BashWorkflowHandler/workflowHandler.sh) and put it into your workflow directory.

Usage
-----

### Import handler into your script
```
. workflowHandler.sh
```

### Create feedback XML
```
# create feedback entries
addResult "uid" "arg" "valid" "title" "subtitle" "icon"

# get feedback xml
getXMLResults
```

### Store preferences
```
# store volatile
setPref "key" "value" 0

# store non-volatile
setPref "key" "value" 1
```

### Read preferences
```
# read volatile pref
MYVAR=$(getPref "key" 0)

# read non-volatile pref
MYVAR=$(getPref "key" 1)
```
