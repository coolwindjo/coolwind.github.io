---
layout: page
title: Gallery
subtitle: From the posting folder
permalink: /gallery/
gallery_path: "assets/img/posting"
tags: [Gallery, Photo]
---

This is a photo gallery made from the static files in the `assets/img/posting` folder. 
I wanted to create automatically a simple gallery from a folder without having to create a markdown page as you would for the portfolio.


{% include gallery.html gallery_path=page.gallery_path %}