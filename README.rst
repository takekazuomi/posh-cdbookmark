============
 posh-cdbookmark
============

Inspired by cd-bookmark of zsh plugin.

https://github.com/mollifier/cd-bookmark



How to install
==============
You can install from PowerShell Gallery. `Cdbookmark <https://www.powershellgallery.com/packages/posh-cdbookmark>`_

.. code:: posh

Install-Module -Name posh-cdbookmark


create bookmark
===============

.. code:: posh

   Add-Cdbookmark -Name foo -Path .


cd bookmark directory
=====================

.. code:: posh

   cdb foo


remove bookmark
===============

.. code:: posh

   Remove-CdBookmark foo


list bookmarks
==============

.. code:: posh

   $ Get-CdBookmark

   Name                           Value
   ----                           -----
   kyrtblog                       C:\home\takekazu\Dropbox\kyrt\site
   tech.c                         C:\home\takekazu\Dropbox\project\tech.c
   psdirenv                       C:\ws\posh\psdirenv
   cdb                            C:\GitHub\takekazuomi\Cdbookmark


Additional Information
======================
Bookmark is stored in $HOME/.cdbookmark.


C:\Users\takekazu
$ cat C:\Users\takekazu\.cdbookmark
{
    "tech.c":  "C:\\home\\takekazu\\Dropbox\\project\\tech.c",
    "cdb":  "C:\\GitHub\\takekazuomi\\Cdbookmark",
    "kyrtblog":  "C:\\home\\takekazu\\Dropbox\\kyrt\\site"
}
