using Images, ImageFiltering

##
xiaomi = imresize(load("xiaomi.jpg"), ratio = 0.2)

##
function edge_detect(xiaomi, scale=5)
    k = Kernel.sobel()
    xiaomi_edges_x = imfilter(xiaomi, k[1]);
    xiaomi_edges_xy = imfilter(xiaomi, k[1]+k[2]);
    xiaomi_edges_y = imfilter(xiaomi, k[2]);
    xiaomi_edges_yx = imfilter(xiaomi, k[1] - k[2]);

    xiaomi_edges = [xiaomi_edges_x xiaomi_edges_xy;
                    xiaomi_edges_yx xiaomi_edges_y]

    xiaomi_edges ./= max(channelview(xiaomi_edges)...)
    xiaomi_edges .* scale
end

edge_detect(xiaomi)