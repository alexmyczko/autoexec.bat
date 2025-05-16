# Slurm

## Installation

On Debian based systems, you'll want to have at least a submit node and compute nodes.
For the submit node you would install `munge slurmdbd slurmd slurmctld slurm-client`
and the compute nodes `munge slurm-client slurmd slurm-client`.

The munge key must be equal everywhere.

Now configure all nodes to have the same `/etc/slurm/slurm.conf`, additional configs you
might want to set up are `cgroups.conf` (https://slurm.schedmd.com/cgroup_v2.html) and `gres.conf`.
`lscpu` might be useful when setting up `slurm.conf` NodeName= part.
You might want to add more plugins, see `apt-cache search ^slurm-wlm |grep "plugin -"`

## Usage

There are different ways to submit jobs:
- `srun` (runs attached, ctrl-c ctrl-c to abort)
- `srun -w prefereddestination--pty $SHELL` to login to a node and use it interactively
- `sbatch` (runs detached)

To monitor your jobs:
- `squeue -u $USER`
- `scontrol show job`
- `sinfo` cluster node status

To see details of your cluster:
- `scontrol show partition`
- `scontrol show config`
- `scontrol -o show node`

Some admin tasks:
- `systemctl restart slurmctld` restart central management daemon
- `scontrol reconfigure` reread configuration

## Cheat sheet

https://slurm.schedmd.com/pdfs/summary.pdf
