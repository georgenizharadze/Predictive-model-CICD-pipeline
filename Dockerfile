FROM trestletech/plumber 
LABEL Name=capstone Version=0.0.1
WORKDIR /app
COPY plumber_ml.r linear_model.rds ./
ENTRYPOINT ["R", "-e", "pr <- plumber::plumb(commandArgs()[4]); pr$run(host='0.0.0.0', port=8000, swagger=TRUE)"]
CMD ["/app/plumber_ml.R"]