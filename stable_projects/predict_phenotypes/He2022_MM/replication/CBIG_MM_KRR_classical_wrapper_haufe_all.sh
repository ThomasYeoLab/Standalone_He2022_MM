#!/bin/sh
# Written by Tong He and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

# Initialize directory
input_dir="$CBIG_REPDATA_DIR/stable_projects/predict_phenotypes/He2022_MM"
base_dir="$CBIG_CODE_DIR/stable_projects/predict_phenotypes/He2022_MM"
code_dir="${base_dir}/KRR_CLASSICAL"
rep_dir="${base_dir}/replication"

# Initialize input and output
ks=(1019)
split="diff_roi"
final_phe_list="${input_dir}/HCP_${split}_final_phe_list.txt"
output="${rep_dir}/output_KRR_classical_haufe_all"
phe_csv="${input_dir}/HCP_${split}_final.csv"
subj_list="${input_dir}/HCP_${split}_subj_list.txt"
fc_mat="${input_dir}/HCP_${split}_pfc.mat"
n_rngs="1"

# Run KRR by submitting job
for k in "${ks[@]}"; do
	while read p; do
		n_job="$(qstat -u the | wc -l)"
		while [ $n_job -gt 50 ]; do
			echo $n_job large than 50, sleep for 1 mins
			sleep 1m
			n_job="$(qstat -u the | wc -l)"
		done
		sh CBIG_MM_KRR_classical_submit_job_haufe.sh $p $output $phe_csv $code_dir $k $split $subj_list $fc_mat $n_rngs
	done <$final_phe_list
done
