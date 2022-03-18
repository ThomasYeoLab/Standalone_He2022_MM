classdef test_MARS_warpPointbyTangentVec < matlab.unittest.TestCase
% Written by Jianzhong Chen and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md

    methods (Test)
        function test2inputs(testCase)
            % load input and ref output
            CBIG_CODE_DIR = getenv('CBIG_CODE_DIR');
            replace_unit_test = load(fullfile(CBIG_CODE_DIR, 'unit_tests', 'replace_unittest_flag'));
            cur_dir = fullfile(CBIG_CODE_DIR, 'unit_tests', 'external_packages', 'SD', 'SDv1.5.1-svn593', ...
                'BasicTools', 'MARS_warpPointbyTangentVec');
            load(fullfile(cur_dir, 'ref_output', 'expectedResult_2inputs.mat'));
            load(fullfile(cur_dir, 'input', 'input.mat'));
            newResult = MARS_warpPointbyTangentVec(input.pt,input.tangent);
            
            % replace unit test if flag is 1
            if replace_unit_test
                % display differences
                disp("Replacing unit test for MARS_warpPointbyTangentVec, test2inputs");
                disp(['Old field size is [' num2str(size(expectedResult)) ']'] );
                disp(['New field size is [' num2str(size(newResult)) ']']);
                disp(['Sum of absolute difference in result is ' num2str(sum(sum(abs(newResult - expectedResult)))) ]);              
                
                % save and load new output file
                expectedResult = newResult;
                output_file = fullfile(cur_dir, 'ref_output', 'expectedResult_2inputs.mat');
                save(output_file,'expectedResult');
                load(output_file);
            end
            
            assert(all(size(newResult) == size(expectedResult)), 'size of output is different')
            assert(all(all(abs(newResult - expectedResult) < 1e-6)), sprintf('output off by %f', sum(sum(abs(newResult - expectedResult)))));
            
        end
        
        function test3inputs(testCase)
            % load input and ref output
            CBIG_CODE_DIR = getenv('CBIG_CODE_DIR');
            replace_unit_test = load(fullfile(CBIG_CODE_DIR, 'unit_tests', 'replace_unittest_flag'));
            cur_dir = fullfile(CBIG_CODE_DIR, 'unit_tests', 'external_packages', 'SD', 'SDv1.5.1-svn593', ...
                'BasicTools', 'MARS_warpPointbyTangentVec');
            load(fullfile(cur_dir, 'ref_output', 'expectedResult_3inputs.mat'));
            load(fullfile(cur_dir, 'input', 'input.mat'));
            newResult = MARS_warpPointbyTangentVec(input.pt,input.tangent,input.radius);
            
            if replace_unit_test
                % display differences
                disp("Replacing unit test for MARS_warpPointbyTangentVec, test3inputs");
                disp(['Old field size is [' num2str(size(expectedResult)) ']'] );
                disp(['New field size is [' num2str(size(newResult)) ']']);
                disp(['Sum of absolute difference in result is ' num2str(sum(sum(abs(newResult - expectedResult)))) ]);              
                
                % save and load new output file
                expectedResult = newResult;
                output_file = fullfile(cur_dir, 'ref_output', 'expectedResult_2inputs.mat');
                save(output_file,'expectedResult');
                load(output_file);
            end
            
            assert(all(size(newResult) == size(expectedResult)), 'size of output is different')
            assert(all(all(abs(newResult - expectedResult) < 1e-6)), sprintf('output off by %f', sum(sum(abs(newResult - expectedResult)))));
            
        end
    end

end