#!/bin/bash

ls | grep dep | xargs rm
ls | grep dpth | xargs rm
ls | grep md5 | xargs rm
ls | grep aux | xargs rm
ls | grep log | xargs rm

