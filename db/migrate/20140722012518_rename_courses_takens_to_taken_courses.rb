class RenameCoursesTakensToTakenCourses  < ActiveRecord::Migration
    def self.up
        rename_table :courses_takens, :taken_courses
    end 
    def self.down
        rename_table :taken_courses, :courses_takens
    end
 end
