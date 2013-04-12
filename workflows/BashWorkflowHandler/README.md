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
#### Example
```
# create feedback entries
# addResult "uid" "arg" "title" "subtitle" "icon" "valid" "autocomplete"
addResult "itemuid" "itemarg" "the item title" "the item subtitle" "icon.png" "yes" "autocomplete"

# get feedback xml
getXMLResults
```
#### Result
```
<?xml version='1.0'?><items>
  <item uid='itemuid' arg='itemarg' valid='yes' autocomplete='autocomplete'>
    <title>the item title</title>
    <subtitle>the item subtitle</subtitle>
    <icon>icon.png</icon>
  </item>
</items>
```

### Get BundleID
#### Example
```
BUNDLEID=$(getBundleId)
echo "$BUNDLEID"
```
#### Result
```
com.markokaestner.myworkflow
```

### Get workflow data dir
#### Example
```
DATADIR=$(getDataDir)
echo "$DATADIR"
```
#### Result
```
/Users/markokaestner/Library/Application Support/Alfred 2/Workflow Data/com.markokaestner.myworkflow
```

### Get workflow cache dir
```
CACHEDIR=$(getCacheDir)
echo "$CACHEDIR"
```
#### Result
```
/Users/markokaestner/Library/Caches/com.runningwithcrayons.Alfred-2/Workflow Data/com.markokaestner.myworkflow
```

### Store preferences
#### Example
```
# store volatile pref in default settings file
setPref "key" "value" 0

# store non-volatile pref in default settings file
setPref "key" "value" 1

# store volatile pref in specified file
setPref "key" "value" 0 "myprefs.txt"

# store non-volatile pref in specified file
setPref "key" "value" 1 "myprefs.txt"
```

### Read preferences
#### Example
```
# read volatile pref from default settings file
MYVAR=$(getPref "key" 0)

# read non-volatile pref from default settings file
MYVAR=$(getPref "key" 1)

# read volatile pref from specified file
MYVAR=$(getPref "key" 0 "myprefs.txt")

# read non-volatile pref from specified file
MYVAR=$(getPref "key" 1 "myprefs.txt")
```
