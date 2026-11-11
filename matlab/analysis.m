data = readfile('data.txt', 'time log_size threads run_order rep size')

fprintf("\n mfit \n")
mfit(data.time, data.log_size, data.threads)

fprintf("\n stats with time and log_size \n")
stats(data.time, data.log_size)

fprintf("\n stats with time and threads \n")
stats(data.time, data.threads)

figure(1)
mplot(data.time, 10.^(data.log_size), data.threads)

figure(2)
mplot(data.time, data.threads, 10.^(data.log_size))

figure(3)
bplot2(data.time, data.threads)

figure(4)
bplot2(data.time, data.log_size)
