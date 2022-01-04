#!/bin/sh 
#BSUB -q gpuv100
#BSUB -gpu "num=1"
#BSUB -J YOLOSWAg
#BSUB -n 1
#BSUB -R "rusage[mem=2GB]" ### Training needs 10GB, annotating needs 2GB
#BSUB -M 2GB ### Training needs 10GB, annotating needs 2GB
#BSUB -W 2:00 ### Max on GPU seems to be 24 hours
#BSUB -o Output.out 
#BSUB -e Error.err

module load cudnn/v8.0.4.30-prod-cuda-11.1
module load opencv/3.4.16-python-3.8.11-cuda-11.1

###Train from pre-trained weights
###./darknet detector train data/singleclass.data cfg/yolov3-singleclass.cfg darknet53.conv.74 -map -dont_show | tee results/output.log

###Continue fine-tuning
###./darknet detector train data/singleclass.data cfg/yolov3-singleclass.cfg backup/yolov3-singleclass_last.weights -map -dont_show | tee results/output2.log

###Test on video
./darknet detector demo data/singleclass.data cfg/yolov3-singleclass.cfg backup/yolov3-singleclass_80000.weights -dont_show test.mp4 -out_filename results/result.mp4

###Test on image
###./darknet detector test data/singleclass.data cfg/yolov3-singleclass.cfg backup/yolov3-singleclass_80000.weights -dont_show test.jpg
