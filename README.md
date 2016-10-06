Django + Mysql + Solr
=====================

Installation

```
vagrant up
vagrant ssh
cd web/app/
workon vweb
```

Install Python dependencies

```
pip install -r requirements.txt
```
Run Django and update Solr
```
./manage.py makemigrations
./manage.py migrate
./manage.py rebuild_index
./manage.py update_index
./manage.py runserver 0.0.0.0:8000
```

Routes
------

Web:
http://192.168.100.3:8000/

Solr:
http://192.168.100.3:8983/solr/#/

Solr Example

http://192.168.100.3:8000/notes/


Update project
==============

Update python
-------------
pip freeze > requirements.txt

Rebuild Schema
--------------
./manage.py build_solr_schema > ~/web/schema.xml

cp ~/web/schema.xml ~/solr-4.10.2/example/solr/collection1/conf/schema.xml

