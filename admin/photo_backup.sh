#!/bin/bash

backupdir='/opt/backups/photos'
photohost='web1.slh.madhattermm.com'
user='rails'
opts='-azv'

#backup photos

rsync $opts $user@$photohost:/var/rails/spotadouche/application/public/photos $backupdir/ > $backupdir/photos.log
rsync $opts $user@$photohost:/var/rails/spotadouche/application/public/photo_thumbs $backupdir/ > $backupdir/photo_thumbs.log

