# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?


p1 = Post.new(title: "Cap 1:", content: "…. It all started when I ingested a 250 micrograms of LSD,

Yes, that is still a thing in 2021, you would not be able to believe the change I went through after it.

I ended up doing Ayahuasca in the Peru jungle, I found the love of my life, ended up fixing so many relationships I didn’t even know were broken, and the most important one, was with myself.

This is just an introduction but if you are interested somehow on: DROGS, LSD, MOOSHROOMS, DMT, Girls, RELATIONSHIPS, GOD, SELF, PARALLEL REALITY AND MORE!!! lol

I'm kind of your guy.

Let me introduce myself, I'm calling myself from now on, Ram Dass Dass, as this domain suggests.

I do software development, I do photography and I try to live how a life should be lived, with no expectation for the future and with all the good vibes I can let in.

One day I was watching a youtube video when suddenly I felt an urge to sit and try to meditate, since that day I started doing it more and more, that was the first experience I have and still one of the most beautiful ones.

I travel through time, space, meet all the light you could possibly might imagine and I thought that was just a couple of mins but it were close to 45 mins, that keep being the time I spend almost daily on meditation, That mark has been there for a while now that I think about it, unless i'm doing some kind of psychedelic like LSD or Ayahuasca, with that I can go for hours in, I just close my eyes and I can be so deep that 4 or 5 hours go by and I'm still lost in a world way more real that the one where i'm writing this and the one where you are reading this.



One big part of my awaiking was the understanding that my body and my mind are completely separated.

I remember been so crazy in my body the first time I did LSD that all I was doing was screming and telling to myself that I didn’t know what was happening, didn’t know what was my name, what music I like the most and where the fuck where I was.



Details later but for now think about it like this:

In software development there is a structure called loops.
that goes like this:

array = [1,2,3,4,5,6,7]
where “array” could be compose by any kind of thing, numbers, letters, other structures, and you can go through them, just like you go with you daily routine:

array = [‘open_my_eyes’, ‘brush_my_teeths’, ‘go_to_work’]

and every day you go and iterate through it.


days.each do |day|
  array.each do |event|
    # Event being ‘open_my_eyes’, ‘go_to_work’ etc.
    day.execute(event)
  end
end


Every one of us has a set of events that we do daily. Some events are more exciting than others, like the day I met teri_luna or the day I did LSD or the day I felt I was Jesus Crist. All those stories are coming, bear with me.

But as in software development even though I was in a loop of everyday life, I had a break sentence included in my loop that day. So breaks in software development are little sentences that depending on something make the loop stop and go to something else.

so you have:

days.each do |day|
  array.each do |event|
    # Event being ‘open_my_eyes’, ‘go_to_work’ etc.
    if im_sick?
      day.stop! # this is a break sentence
   else
     day.execute(event)
   end
  end
end



Note for the reader: if this is too boring stop reading, your mind is too lazy to understand the rest of it.

for me that day.stop! It was my friend Nico, the one who introduced me to Lucy, and since that day I understood Lucy will be a big part of my life.

I was getting paid way more money than I ever imagined, was living on the top floor of a building in a city well known for being so cool, so nice, so beautiful in my native country. I was kind at the top of the work for a 24 years old boy.

Away from my family living with a beautiful girlfriend and an awesome dog called Mandala.

After some circumstances Nico was in the city and Andres another dear friend of mine let me know Nico was there, so we arranged and met at my apto.

Nico brought a tap of LSD, I would guess it was about 250ug (micrograms). as soon as he ingested just a little bit of the corner of the tab all his face changed, he told me he was starting to see colors different in like 15 mins, and he said to me: “and you how are you?”; We were talking for an hour by now but that question sounded different, he was way more relaxed and his shoulders were down and he was seeing my eyes in a different way. He insisted I tried some LSD right away. I did not want to do it yet.
")

p1.save!
puts "Post 1 saved!"
