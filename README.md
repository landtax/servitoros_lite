# Contawords

ContaWords counts the words of any texts. 
It can be used in contawords.iula.upf.edu

## Installation

Requirements:
* Ruby 1.9.3 or later
* Mysql 
* Taverna server 2.4 installed (http://www.taverna.org.uk/documentation/taverna-2-x/server/)
* Feed Buzzer (https://github.com/landtax/feed_buzzer)

All required gems are specified in Gemfile, so just type
> bundle install

like any other rails app.

Create the DB
> rake db:schema:load

The app needs a workflow to run. Just one. It will take the first in the DB.
The workflow is already in the db/data folder.
Open the rails console and create a workflow

```
> w = Workflow.new
> w.taverna_workflow = File.open(Rails.root.join("db/data/workflow.t2flow"))
> w.save
```
## What it does

On every new word count, it connects to taverna server and sends the workflow with the parameters.
In the background, feed buzzer is suposed to ask to taverna server when the job is done and notify the app.


