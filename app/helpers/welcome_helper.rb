module WelcomeHelper
	def grade_department_courses(grade_courses, d)
		dept = Department.find_by_name(d)
		dept_courses = dept.courses rescue []
		grade_courses & dept_courses
	end
end
