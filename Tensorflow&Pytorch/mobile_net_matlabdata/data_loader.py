import numpy as np
import matplotlib.pyplot as plt


class DataLoader:
    """Data Loader class. As a simple case, the model is tried on TinyImageNet. For larger datasets,
    you may need to adapt this class to use the Tensorflow Dataset API"""

    def __init__(self, batch_size, shuffle=False):
        self.X_train = None
        self.y_train = None
        self.img_mean = None
        self.train_data_len = 0

        self.X_val = None
        self.y_val = None
        self.val_data_len = 0

        self.X_test = None
        self.y_test = None
        self.test_data_len = 0

        self.shuffle = shuffle
        self.batch_size = batch_size

    def load_data(self):
        # Please make sure to change this function to load your train/validation/test data.
        #train_data = np.array([plt.imread('./data/test_images/0.jpg'), plt.imread('./data/test_images/2.jpg'),
        #            plt.imread('./data/test_images/4.jpg'), plt.imread('./data/test_images/6.jpg')])
        train_data = np.array([plt.imread('./data/test_images/0.jpg'), plt.imread('./data/test_images/2.jpg'),
                    plt.imread('./data/test_images/4.jpg'), plt.imread('./data/test_images/6.jpg'),
                    plt.imread('./data/test_images/8.jpg'), plt.imread('./data/test_images/10.jpg'),
                    plt.imread('./data/test_images/12.jpg'), plt.imread('./data/test_images/14.jpg'),
                    plt.imread('./data/test_images/16.jpg'), plt.imread('./data/test_images/18.jpg'),
                    plt.imread('./data/test_images/20.jpg'), plt.imread('./data/test_images/22.jpg'),
                    plt.imread('./data/test_images/24.jpg'), plt.imread('./data/test_images/26.jpg'),
                    plt.imread('./data/test_images/28.jpg'), plt.imread('./data/test_images/30.jpg'),
                    plt.imread('./data/test_images/32.jpg'), plt.imread('./data/test_images/34.jpg'),
                    plt.imread('./data/test_images/36.jpg'), plt.imread('./data/test_images/38.jpg'),
                    plt.imread('./data/test_images/40.jpg'), plt.imread('./data/test_images/42.jpg'),
                    plt.imread('./data/test_images/44.jpg'), plt.imread('./data/test_images/46.jpg'),
                    plt.imread('./data/test_images/48.jpg')])
        print ('----------------A Image data is :----------------\n',train_data[0][0][0])
        # used to have four picture,and four label: y_train = np.array([289,322,1,4])

        print('CYJ:  len of train_data : ',len(train_data))
        self.X_train = train_data
        #self.y_train = np.array([100,200,300,400])
        self.y_train = np.array([10,10,10,10,10,20,20,20,20,20,30,30,30,30,30,40,40,40,40,40,50,50,50,50,50])

        #val_data = np.array([plt.imread('./data/test_images/0.jpg'), plt.imread('./data/test_images/2.jpg'),
        #            plt.imread('./data/test_images/4.jpg'), plt.imread('./data/test_images/6.jpg')])    
        val_data=np.array([plt.imread('./data/test_images/0.jpg'), plt.imread('./data/test_images/2.jpg'),
                    plt.imread('./data/test_images/4.jpg'), plt.imread('./data/test_images/6.jpg'),
                    plt.imread('./data/test_images/8.jpg'), plt.imread('./data/test_images/10.jpg'),
                    plt.imread('./data/test_images/12.jpg'), plt.imread('./data/test_images/14.jpg'),
                    plt.imread('./data/test_images/16.jpg'), plt.imread('./data/test_images/18.jpg'),
                    plt.imread('./data/test_images/20.jpg'), plt.imread('./data/test_images/22.jpg'),
                    plt.imread('./data/test_images/24.jpg'), plt.imread('./data/test_images/26.jpg'),
                    plt.imread('./data/test_images/28.jpg'), plt.imread('./data/test_images/30.jpg'),
                    plt.imread('./data/test_images/32.jpg'), plt.imread('./data/test_images/34.jpg'),
                    plt.imread('./data/test_images/36.jpg'), plt.imread('./data/test_images/38.jpg'),
                    plt.imread('./data/test_images/40.jpg'), plt.imread('./data/test_images/42.jpg'),
                    plt.imread('./data/test_images/44.jpg'), plt.imread('./data/test_images/46.jpg'),
                    plt.imread('./data/test_images/48.jpg')])
        self.X_val = val_data
        self.y_val = np.array([10,10,10,10,10,20,20,20,20,20,30,30,30,30,30,40,40,40,40,40,50,50,50,50,50])
        # used to have 4 value.

        self.train_data_len = self.X_train.shape[0] # there are 4 pictures , x_train.shape == 4 *(image_width * image_height)
        self.val_data_len = self.X_val.shape[0]
        img_height = 220
        img_width = 320
        num_channels = 3
        return img_height, img_width, num_channels, self.train_data_len, self.val_data_len

    def generate_batch(self, type='train'):
        """Generate batch from X_train/X_test and y_train/y_test using a python DataGenerator"""
        if type == 'train':
            # Training time!
            new_epoch = True
            start_idx = 0
            mask = None
            while True:
                if new_epoch:
                    start_idx = 0
                    if self.shuffle:
                        mask = np.random.choice(self.train_data_len, self.train_data_len, replace=False)
                    else:
                        mask = np.arange(self.train_data_len)
                    new_epoch = False

                # Batch mask selection
                X_batch = self.X_train[mask[start_idx:start_idx + self.batch_size]]
                print('X_batch is :',X_batch)
                y_batch = self.y_train[mask[start_idx:start_idx + self.batch_size]]
                print('y_batch is :',y_batch)
                start_idx += self.batch_size

                # Reset everything after the end of an epoch
                if start_idx >= self.train_data_len:
                    new_epoch = True
                    mask = None
                yield X_batch, y_batch
        elif type == 'test':
            # Testing time!
            start_idx = 0
            while True:
                # Batch mask selection
                X_batch = self.X_test[start_idx:start_idx + self.batch_size]
                y_batch = self.y_test[start_idx:start_idx + self.batch_size]
                start_idx += self.batch_size

                # Reset everything
                if start_idx >= self.test_data_len:
                    start_idx = 0
                yield X_batch, y_batch
        elif type == 'val':
            # Testing time!
            start_idx = 0
            while True:
                # Batch mask selection
                X_batch = self.X_val[start_idx:start_idx + self.batch_size]
                y_batch = self.y_val[start_idx:start_idx + self.batch_size]
                start_idx += self.batch_size

                # Reset everything
                if start_idx >= self.val_data_len:
                    start_idx = 0
                yield X_batch, y_batch
        else:
            raise ValueError("Please select a type from \'train\', \'val\', or \'test\'")
