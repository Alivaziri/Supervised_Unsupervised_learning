# Supervised_Unsupervised_learning
It is a single freedom mass, spring damper system which I built a Simulink model of it in MATLAB.
Firstly, to provide rich data I decided to use a harmonic signal as an input to our Simulink model. Therefore, I used the output of the model for training the neural network.
I normalize the data in order to use them in my sigmoid function.
I did not use an Elman re-current because of the simplicity of the system.
For training my neural network I used propagation function and sigmoid activation function.
And for updating the weights I used Error Back Propagation.
In the first step of training there was not a re-current. (static learning stage to avoid diversion of ERORR). And for second one I connect a Jordan re-current to the neural network. (dynamic learning stage)
Finally, I tested the neural network with another harmonic input. And hopefully, the results of the neural network were close to the output of the Simulink model with a good accuracy.
In the second project I used an on/off controller for our dynamic system to provide dataset for the first stage of learning.  Then I used the data for training the controller neural network using error back propagation method. I name this stage of learning as supervised learning. And finally, I implemented the initialized controller before our dynamic model to only train the controller neural network in an online procedure using optimization algorithm to avoid the diversion of Error.
The most important part was input of the controller neural network which was Error. I used an evaluation function for optimization algorithm which resulted in conversion in error. I name this stage of learning as unsupervised learning because I did not have any data to train the neural network. Finally, the controller neural network was designed and accurately resulted in desired position of the dynamic system.
![UnsupervisedLearning](https://github.com/Alivaziri/Supervised_Unsupervised_learning/assets/24912257/96196a5b-c671-429d-aa48-934694bef4bf)


