// Function to find the waiting time for all
// processes
List<dynamic> findWaitingTime(var processes, var n, var bt, var at)
{
  var wt=[];
var service_time=[];//n size
service_time.add(at[0]);
wt.add(0);

// calculating waiting time
for (int i = 1; i < n ; i++)
{
// Add burst time of previous processes
service_time.add(service_time[i-1] + bt[i-1]);
// Find waiting time for current process =
// sum - at[i]
wt.add(service_time[i] - at[i]);
// If waiting time for a process is in negative
// that means it is already in the ready queue
// before CPU becomes idle so its waiting time is 0
if (wt[i] < 0)
  wt[i] = 0;
}
return wt;
}

// Function to calculate turn around time
List<dynamic> findTurnAroundTime(var processes, int n, var bt,var wt)
{
  var tat=[];
// Calculating turnaround time by adding bt[i] + wt[i]
for (int i = 0; i < n ; i++)
  tat.add( bt[i] + wt[i]);

return tat;
}

// Function to calculate average waiting and turn-around
// times.
void findavgTime(var processes, int n, var bt, var at)
{
  // var wt=[];//n size
  // var tat=[];//n size

// Function to find waiting time of all processes
List<dynamic> wt=findWaitingTime(processes, n, bt, at);

// Function to find turn around time for all processes
List<dynamic> tat=findTurnAroundTime(processes, n, bt, wt);

// Display processes along with all details
print("Processes \t Burst Time \t Arrival Time \t Waiting Time \t Turn-Around Time \t Completion Time \n");
num total_wt = 0, total_tat = 0;
for (int i = 0 ; i < n ; i++)
{
total_wt = total_wt + wt[i];
total_tat = total_tat + tat[i];
int compl_time = tat[i] + at[i];
print(" ${i+1} \t\t ${bt[i]} \t\t ${at[i]} \t\t ${wt[i]} \t\t ${tat[i]} \t\t ${compl_time} \n");
}

print("Average waiting time = ${(total_wt.toDouble()) / (n.toDouble())}\n");
print("Average turn around time = ${(total_tat.toDouble()) / (n.toDouble())}\n");
}

// Driver code
void main_algo(int processes_size,var bt,var at)
{
// Process id's
var processes=[];
for(int i=1;i<processes_size;i++){
  processes.add(i);}
findavgTime(processes, processes_size, bt, at);
}
