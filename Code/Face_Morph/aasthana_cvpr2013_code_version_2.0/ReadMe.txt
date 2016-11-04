Copyright (C) 2013 Akshay Asthana and Shiyang Cheng

****Updated on 21 August 2013****

****Do not redistribute without permission****

****For Research Purposes Only****

This code is released along with the CVPR 2013 paper [1] entitled "Robust
Discriminative Response Map Fitting with Constrained Local Models".

Enjoy!

Akshay Asthana
akshay.asthana@gmail.com

Shiyang Cheng
shiyang.cheng11@imperial.ac.uk

------------------------------

Bug Reporting:

For bug reporting, please email me at akshay.asthana@gmail.com

------------------------------

About the Code:

"Demo.m" shows how to run the code.

"mex_functions" folder contains mex-files that require compilation.
Linux and Windows binaries are included in this code.

"Point Distribution Model" has been provided by Saragih et al. [2] that
was trained by applying the non-rigid-structure-from-motion on Multi-PIE
database.

"External_Face_Detector.m" supports the functionality for incorporating
your own preferred face detector with the DRMF fitting.

------------------------------

About the Face Detector:

The inbuilt matlab face detector is not very accurate. Moreover, it fails
regularly on faces with varying illumination, expression and pose,
particularly, on the 'wild' faces.

Therefore, as an alternative, this code also contains a robust face
detector based on the tree-based method [3].

http://www.ics.uci.edu/~xzhu/face/

"p204-Wild.mat" is the model that can be used for face detection via
tree-based method [2]. See Section 4.3 of the paper [1] for details on
how this model is trained.

Moreover, the code also supports the functionality for incorporating
your own preferred face detector with the DRMF fitting. For this,
Simply modify the function "External_Face_Detector.m"

------------------------------

Acknowledgement:

"face_detector/functions" folder contains the code of Zhu and Ramanan [1]
that can be used for face detection. This folder contains mex-files that
require compilation. Linux and Windows binaries are included in this code.

------------------------------

References:

[1] A. Asthana, S. Zafeiriou, S. Cheng and M. Pantic.
Robust Discriminative Response Map Fitting with Constrained Local Models.
In CVPR 2013.

[2] J. Saragih, S. Lucey and J. Cohn.
Deformable Model Fitting by Regularized Landmark Mean-Shifts.
In IJCV 2010.

[3] X. Zhu, D. Ramanan.
Face detection, pose estimation and landmark localization in the wild.
In CVPR 2012.
