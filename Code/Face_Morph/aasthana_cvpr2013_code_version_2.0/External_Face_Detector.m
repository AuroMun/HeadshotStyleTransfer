function bbox = External_Face_Detector(imgpath,img)
% % % Use this function for incorporating your own preferred face detector.
% % % The function should return the bounding box in the same format as the matlab face detector.
% % % 
% % % bbox=[x,y,width,height]
% % % where, (x,y) is the co-ordinate of the upper-left corner
% % % and (width,height) is the size of a bounding box
% % % 

% % % Example using Matlab's Face Detector 
% % % 
% % % faceDetector = vision.CascadeObjectDetector();
% % % bbox = step(faceDetector, img);            
% % % bbox(2)=bbox(2)+5;
% % % 
% % % Refer the following for more details
% % % http://www.mathworks.co.uk/help/vision/ref/vision.cascadeobjectdetectorclass.html
% % % http://www.mathworks.co.uk/help/vision/examples/face-detection-and-tracking.html

    fprintf('--> Face Detection (EXTERNAL detector) ');
    faceDetector = vision.CascadeObjectDetector();
    bbox = step(faceDetector, img);            
    bbox(2)=bbox(2)+5;
        
end
