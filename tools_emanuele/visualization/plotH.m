function plotH(H)
  figure(3);
  title("H matrix");
  H_ =  H./H;                      # NaN and 1 element
  H_(isnan(H_))=0;                 # Nan to Zero
  H_ = abs(ones(size(H_)) - H_);   # switch zero and one
  H_ = flipud(H_);                 # switch rows
  colormap(gray(64));
  hold on;
  image([0.5, size(H_,2)-0.5], [0.5, size(H_,1)-0.5], H_*64);
  refresh()
  hold off;
end
