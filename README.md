# snap-points




Please kindly cite the following paper if you use our implementation in your publications:
```
    @InProceedings{snap-points,
      author = {B. Xiong and K. Grauman},
      title = {Detecting Snap Points in Egocentric Video with a Web Photo Prior},
      booktitle = {ECCV},
      month = {September},
      year = {2014}
    }
```



To Run the code :
    
    First download the features from 
    http://vision.cs.utexas.edu/projects/ego_snappoints/download/mat_file.zip
    Then unzip the file in the code folder.
    The script demo.m test on 10 frames. Note due to space constraint, only a subset of features are 
    included. In order to run on other dataset, please replace with your own feature.

Libraries:

    For the easy installation, we also include their code in our package.
    Please refer to the original packages for their copyright and license agreement.     

    GFK: 
    Geodesic Flow Kernel for Unsupervised Domain Adaptation. B. Gong, Y. Shi, F. Sha, and K. Grauman.
    CVPR, Providence, RI, June 2012
    http://www-scf.usc.edu/~boqinggo/domainadaptation.html
    
    Feature extraction:
    Blurriness and line orientations estimation are included under feature_extraction. Other code for
    feature extraction can be found at:
    https://cs.brown.edu/~gen/sunattributes.html  
    http://www.vlfeat.org/
    
    Web Prior data:
    http://groups.csail.mit.edu/vision/SUN/

    SUN_source_code_v2:
    http://vision.princeton.edu/projects/2010/SUN/
 
License:

    The MIT License (MIT)

    Copyright (c) 2014 Bo Xiong

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
