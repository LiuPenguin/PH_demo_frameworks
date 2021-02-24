#!/usr/bin/env ruby
require 'xcodeproj'

def removeFrameworksBuildPhases(xcodeproj_path, target_name, framework_name)
    # 打开项目工程
	project_path = File.join(File.dirname(__FILE__), xcodeproj_path)
	project = Xcodeproj::Project.open(project_path)
	# target = project.targets.first

	# 遍历target，找到需要操作的target
	targetIndex = 0

	project.targets.each_with_index do |target, index|
	  if target.name  == target_name
	    targetIndex = index
	  end
	end

	target = project.targets[targetIndex]

	# 获取所有静态库文件引用
	framework_ref_list = target.frameworks_build_phases.files_references

	ref_index = 0
	for file_ref_temp in framework_ref_list
	    file_display_name = target.frameworks_build_phases.file_display_names[ref_index]
	    if file_ref_temp then
	        if file_display_name.to_s.end_with?(framework_name) then
	            target.frameworks_build_phases.remove_file_reference(file_ref_temp)
	            ref_index = ref_index - 1
	            puts "#{target}: remove #{framework_name}"
	        end
	    elsif !file_ref_temp then
	        target.frameworks_build_phases.remove_file_reference(file_ref_temp)
	        ref_index = ref_index - 1
	    end
	    ref_index = ref_index + 1
	end

	target.build_phases.each do |phase|
	    if phase.to_s.end_with?('[CP] Copy Pods Resources') then
	      puts "#{target}: remove #{phase}"
	      phase.remove_from_project
	    end
	end

	project.save
end

OneLibsdk_xcodeproj = '../../OneLib/OneLib.xcodeproj'
TwoLinsdk_xcodeproj = '../../TwoLin/TwoLin.xcodeproj'

removeFrameworksBuildPhases(OneLibsdk_xcodeproj, 'OneLib', 'libPods-OneLib.a')
removeFrameworksBuildPhases(OneLibsdk_xcodeproj, 'TwoLin', 'libPods-TwoLin.a')
