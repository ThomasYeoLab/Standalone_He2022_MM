classdef test_CBIG_ConvertVox2Ras < matlab.unittest.TestCase
    % Written by Siyi Tang, Jingwei Li and CBIG under MIT license: https://github.com/ThomasYeoLab/CBIG/blob/master/LICENSE.md
    
    methods (Test)
        function testRasCoor(TestCase)
            
            CBIG_CODE_DIR=getenv('CBIG_CODE_DIR');
            load(fullfile(CBIG_CODE_DIR, 'unit_tests', 'replace_unittest_flag'));
            vox_coordinate = [50 50 50; 35 40 10]'; % vox coordinate
            
            vox2ras = [-2     0     0    90; ...
                0     2     0  -126; ...
                0     0     2   -72; ...
                0     0     0     1];
            
            output = CBIG_ConvertVox2Ras(vox_coordinate, vox2ras);
            % compare with reference result
            load(fullfile('ref_output', 'CBIG_ConvertVox2Ras_ref_output.mat'),'ref_output');
            
            if (replace_unittest_flag)
                disp('Replacing unit test reference results for CBIG_ConvertVox2Ras.');
                sprintf('There are %d Vox coordinates are different.\n', sum(sum(ref_output~=output)));
                sprintf('Max difference is %f.\n', max(max(abs(ref_output-output))));
                sprintf('Mean difference is %f.\n', mean(mean(abs(ref_output-output))));
                ref_output=output;
                save(fullfile('ref_output', 'CBIG_ConvertVox2Ras_ref_output.mat'),'ref_output');

            else
                assert(isequal(size(output),size(ref_output)), ...
                    'Ras coordinate is of wrong size.');
                assert(all(all(abs(output - ref_output) < 1e-12)), ...
                    sprintf('Result differed (max abs diff) by %f.', ...
                    max(max(abs(output - ref_output)))));
            end
        end
    end
    
end
