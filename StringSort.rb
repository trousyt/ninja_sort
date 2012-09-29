# StringSort module
# Provides string sorting capability when provided a string array
#################################################################
module StringSort

	module ClassMethods
		def ninja_sort (string_array)
			# define indexes for string comparison
			i, j = 0, 1

			# define sorted array
			sorted = string_array.dup

			# loop through all strings
			while j < string_array.length
				# loop through comparison strings (i, j)
				str1, str2 = string_array[i], string_array[j]
				k, min = 0, [str1.length, str2.length].min

				# loop until we hit the end of the shortest string
				k.upto(min) do |c|

					# case where strings can differ greatly
					# str1 > str2
					if str2[c] < str1[c]
						sorted.swap i, j
						break;
					else str2
						# str1 < str2
						# already sorted, break out
						break;
					end

					# case when both strings are the same, but one is longer
					if (c == min)
						if str1.length > str2.length
							sorted.swap i, j
						end
					end

				#/upto
				end

				# increment counters
				i += 1
				j += 1

			#/while
			end

			# return
			sorted

		#/ninja_sort
		end
	#/ClassMethods
	end

	def self.included (base)
		base.extend(ClassMethods)
	end

#/StringSort
end
class String 	# Mixin
	include StringSort
end

# ArraySwap module
# Provides element swapping functionality
##########################################
module ArraySwap
	def swap (fidx, sidx)
		temp = self[fidx]
		self[fidx] = self[sidx]
		self[sidx] = temp
	end
end
class Array 	# Mixin
	include ArraySwap
end

# book_print method
# Print the strings in an array vertically
def book_print (string_array)
	i, last = 0, string_array.map { |e| e.length }.max

	# loop through max string length
	i.upto(last) do |j|

		# loop through number of strings in array
		string_array.each do |s|
			if j < s.length
				printf '%s ', s[j] 
			else
				print '  '
			end
		#/each
		end
		print "\n"
	#/upto
	end
end

#####################
# Start execution....

sa = ['Foo', 'Bar', 'World', 'Hello']
puts "Unsorted: #{sa}"

# do the sort
sa = String.ninja_sort(sa)
puts "Sorted: #{sa}"

# print the array vertically
book_print sa