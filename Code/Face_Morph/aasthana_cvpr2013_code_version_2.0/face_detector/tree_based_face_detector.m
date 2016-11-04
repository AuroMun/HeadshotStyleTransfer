function current_shape = tree_based_face_detector(im,model)              

    bs = detect(double(im), model, model.thresh);
    bs = clipboxes(im, bs);
    bs = nms_face(bs,0.3); 
        
    % list of correspondance between Tree and Multi-PIE annotation order
    list = [60:-1:52,61:68,16:20,31:-1:27,9:-1:6,3:-1:1,4:5,15:-1:13,10:12, ...
          21,24:26,23:-1:22,35:-1:32,39:41,44,46,51,48,50,36:38,43:-1:42,45,47,49];    
    
    % get the point values
    current_shape = zeros(66,2);
    if size(bs,1) >= 1                  
        if size(bs(1).xy,1) == 68 && size(bs(1).xy,2) == 4
            current_shape = box_to_shape(bs(1),list);                                        
        end     
    end                                       
    
end

% function to convert the box to 66-point shape
function shape = box_to_shape(box,list)

    shape = zeros(size(box.xy,1),2);
    for b = box,
        for i = size(b.xy,1):-1:1;
            x1 = b.xy(i,1);
            y1 = b.xy(i,2);
            x2 = b.xy(i,3);
            y2 = b.xy(i,4);
            x = (x1+x2)/2; y = (y1+y2)/2;    
            shape(i, :) = [x y];     
        end
    end
    
    % change the annotation to Multi-PIE's scheme
    shape = shape(list,:);
    % reserved point index
    idx = [1:60,62:64,66:size(box.xy,1)];
    % clip two points
    shape = [shape(idx,1);shape(idx,2)];    
end
