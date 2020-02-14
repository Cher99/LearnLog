import cv2
import numpy as np
import os


# pic = np.zeros((1000, 1000, 3))
# pic = 255 - pic[:, :]


def data_generate(pic_num):
    if not os.path.exists("./dataset2/"+str(pic_num)):
        os.makedirs("./dataset2/"+str(pic_num))
    for index in range(100):
        pic = cv2.imread("background2.jpg")
        heig = pic.shape[0]
        wid = pic.shape[1]
        for _ in range(pic_num):
            pic_sample_num = np.random.randint(8)
            pic_sample = cv2.imread("dataset_sample/"+str(pic_sample_num+1)+".png")
            width = pic_sample.shape[1]
            height = pic_sample.shape[0]
            # 旋转树叶
            # rotate = np.random.randint(360)
            # M=cv2.getRotationMatrix2D((width/2,height/2),rotate,1)
            # pic_sample=cv2.warpAffine(pic_sample,M,(2*width,height))

            left = np.random.randint(wid-width)
            top = np.random.randint(heig-height)
            right = left + width
            bottom = top +height
            # pic_right = 
            for i in range(height):
                for j in range(width):
                    if top+i >= heig or left+j >= wid:
                        continue
                    pic[top+i, left+j] = pic[top+i, left+j] if all(pic_sample[i, j] == [0,0,0]) else pic_sample[i, j]
        pic = resize(pic, 220, 220)
        cv2.imwrite("dataset2/"+ str(pic_num) + "/" + str(index+1) +".jpg", pic)
    print("数量", pic_num, "已完成")

def resize(img, width, height):
    res = cv2.resize(img, (width, height), interpolation=cv2.INTER_CUBIC)
    return res

if __name__ == "__main__":
     for i in range(50, 100):
         data_generate(i+1)
    '''
    for i in range(100):
        for j in range(100):
            pic_sample = cv2.imread("dataset2/" + str(i+1) + "/" + str(j+1) + ".jpg")
            res = resize(pic_sample, 300, 300)
            cv2.imwrite("dataset1/"+ str(i+1) + "/" + str(j+1) +".jpg", res)
            print(i, j)
            '''
