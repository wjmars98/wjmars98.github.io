---
title: Image Fingerprint
date: 2022-06-07 22:52:29
tags:
	- Basic
---
When I tried to build a database for images, a parameter was required to designed for the identification of each image. 

In this article, I explored how to establish the fingerprint of each image by combining its
image dhash code and text hash code.

<center>
        <img src="./log4j/log4j_logo.jpg" width=80%>
</center>


<!--more-->

# Background
The fingerprint wsa needed when I tried to establish my database for images. This database not only should be able to
insert the new image record, but the old record can be updated when its image content changed. Therefore, it's necessary to
build a parameter including the features of primary key(format name) and image content.

To achieve this two features, I used this two methods below:

1. dHash (image feature)
2. hexdigest (image format name feature)

# dHash Method
In common case, there are three image hash methods(aHash, pHash and dHash) in mython. I chose the dhash method to generate
the image hash code.

Dhash, also known as  Difference Hash, is a quick algorithm to compare in images visually. Comparing to ahash and phash,
this method is far more accurate and quick. That's the most important reason for me to choose this image hash method.

And this method to create dhash is very simple:
1. Convert the image to grayscale
2. Downsize it to a 9x9 thumbnail (size=8 means an 8+1 by 8+1 image)
3. Produce a 64-bit “row hash”: a 1 bit means the pixel intensity is increasing in the x direction, 0 means it’s decreasing
4. Do the same to produce a 64-bit “column hash” in the y direction
5. Combine the two values to produce the final 128-bit hash value

We can apply this method by embedding the following code into our project.
```pycon
import dhash
from PIL import Image

image = Image.open('dhash-test.jpg')
row, col = dhash.dhash_row_col(image)
print(dhash.format_bytes(row, col))
print(dhash.format_hex(row, col))
```

# hexdigest
At first, I used the __hash__() function to get the text parameter's hash code. However, this result hash code varied 
every time the project processed.  This is because ths purpose of __hash__() function is to create the unique hash code
for program to identify, and its result is not fixed which cannot be used as text unique identification code.

Then, I used hashlib library to construct the text hash code. We can use hexdigest() function by embedding the following
code into private code.


```pycon
import hashlib
md5 = hashlib.md5()
md5.update(dev.encode('utf-8'))
format_name_hash = md5.hexdigest()
```

# conference
[1. DHash: Enabling Dynamic and Efficient Hash Tables](https://arxiv.org/abs/2006.00819)
[2. Pypi dhash 1.3](https://pypi.org/project/dhash/)