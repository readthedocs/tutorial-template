Quick Start
===========

This page provides instructions on how to prepare, submit, and check for the consumed time of jobs.

1. Access OBLIVION
------------------

Accessing OBLIVION is made usinh ssh. The user should follow the instructions he received when his account and project were created.


2. Working directory
--------------------

After logged in the user finds himself in his home directory. Change to the project folder by

.. code-block:: console

   cd /mnt/beegfs/projects/PROJECT_ID/USER_NAME
   
where PROJECT_ID is the project folder and USER_NAME is the username


3. Working environment
----------------------

Load the needed modules using module load (for further information see the Environment Modules webpage).

3. In the project directory compile the code and submit it for execution using: sbatch <script_name.sh>.

A script example:



In this script we are setting the number of MPI tasks (ntasks), the number of cores per task (cpus-per-task) and the number of tasks per CPU also referred as socket (ntasks-per-socket). So, this script imposes that 1 core executes 1 MPI task. The compute nodes are being used exclusively by this run (option exclusive), and the queue, which in SLURM is called partition, is the debug queue. Finally the code is executed using srun.

4. To check if the job is in the queue to run just execute squeue.

5. The user can always use sacct to see the CPU time used by the job by using, for example,

sacct –format JobIdRaw,User,Partition,Submit,Start,Elapsed,AllocCPUS,CPUTime,CPUTimeRaw,MaxRSS,State,NodeList -S 2021-02-01 -E 2021-02-02

For more information on the command sacct options at the terminal execute

man sacct

6. The user bob can obtain the total computing time consumed by his jobs over a period of time, say from 01.01.2021 through 05.04.2021 using the command sreport

sreport -t HourPer cluster AccountUtilizationByUser Accounts=ACCOUNTID start=1/1/21 format=Accounts,Login,Used

obtaining



For more information on the command sreport options execute

man sreport

For further information on the SLURM commands see the SLURM webpage.
