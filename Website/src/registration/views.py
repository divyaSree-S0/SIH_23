# from django import forms
from django.contrib.auth import login,authenticate,logout
from django.contrib.auth.hashers import check_password,make_password
from bit_exe_website.settings import EMAIL_HOST_USER
from django.core.exceptions import ValidationError
from django.shortcuts import render,redirect
from djongo import database
from pymongo import MongoClient
from django.db.models import Max
from django.contrib import messages
from .forms import LoginForm,SignupForm
from .models import Users, Conveyors
import pyotp, random
from django.core.mail import send_mail
from django.contrib.auth.models import User
from .models import OTP

# def send_otp(request):
#     if request.method == 'POST':
#         email = request.POST.get('email')
#         user = Users.objects.filter(email=email).first()
        
#         if user:
#             # Generate OTP
#             otp_secret = pyotp.random_base32()
#             otp = pyotp.TOTP(otp_secret)
#             otp_code = otp.now()

#             # Save OTP to the database
#             otp_obj, created = OTP.objects.get_or_create(user=user, email=email)
#             otp_obj.otp_secret = otp_secret
#             otp_obj.save()

#             # Send OTP via email
#             subject = 'Your OTP for Login'
#             message = f'Your OTP for login is: {otp_code}'
#             from_email = f'{email}'  # Update with your email
#             recipient_list = [email]

#             # Add Phone OTP API

#             send_mail(subject, message, from_email, recipient_list)

#             return redirect('verify_otp')
#         else:
#             return render(request, 'send_otp.html', {'message': 'Email not found'})
#     else:
#         return render(request, 'send_otp.html')
    

# def verify_otp(request):
#     if request.method == 'POST':
#         email = request.POST.get('email')
#         otp_code = request.POST.get('otp')
        
#         otp_obj = OTP.objects.filter(email=email).first()
        
#         if otp_obj:
#             otp = pyotp.TOTP(otp_obj.otp_secret)
#             print(otp_obj.otp_secret)
#             print(otp_code)
#             print(otp.verify(otp_code))
#             if otp.verify(otp_code):
#                 otp_obj.is_verified = True
#                 otp_obj.save()
#                 user = authenticate(request, username=otp_obj.user.username, password='')
#                 if user:
#                     # login(request, user)
#                     return redirect('login')  # Replace 'home' with the URL name of your home page
#                 else:
#                     return redirect('verify')  # Replace 'login' with the URL name of your home page
#             else:
#                 return render(request, 'verify_otp.html', {'message': 'Invalid OTP'})
#         else:
#             return render(request, 'verify_otp.html', {'message': 'OTP not found'})
#     else:
#         return render(request, 'verify_otp.html')


# Function to generate OTP and send via email
# def send_otp_email(request, email):
#     # Generate OTP
    
#     otp = pyotp.TOTP('base32secret3232').now()

#     # Send OTP to user's email
#     send_mail(
#         'OTP Verification',
#         f'Your OTP is {otp}',
#         f'{email}',
#         [email],
#         fail_silently=False,
#     )
#     return otp  # Return OTP for verification

#


        

      
# Assume this view is for OTP verification
# def verify_otp_view(request):
#     if request.method == 'POST':
#         # Get user input OTP from the verification form
#         user_otp = request.POST.get('otp')

#         # Retrieve the stored OTP from session for comparison
#         stored_otp = request.session.get('otp')
#         email = request.session.get('email')

#         # Compare user input OTP with the stored OTP
#         if user_otp == stored_otp:
#             # Clear the OTP and email from session after successful verification
#             del request.session['otp']
#             del request.session['email']

#             # Grant access to the user (for example: redirect to dashboard)
#             return redirect('dashboard')
#         else:
#             # Handle invalid OTP (you can also redirect back to OTP verification page)
#             return render(request, 'verify_otp.html', {'error': 'Invalid OTP'})

#     return render(request, 'verify_otp.html')


# def send_otp_email(request, email):
#     otp = pyotp.TOTP('base32secret3232').now()
#     send_mail(
#         'OTP Verification',
#         f'Your OTP is {otp}',
#         f'{email}',
#         [email],
#         fail_silently=False,
#     )
#     return otp  

# counter = 1

def create_user_collection(request):
    username = request.session['username']
    client = MongoClient("mongodb://localhost:27017/")
    db = client['BIT_exe'] 
    # client = MongoClient(database.client)
    # db = client[database.name]
    collection_name = f'{username}1'
    db.create_collection(collection_name)

# Create your views here.
def LoginView(request):
    if request.method == 'POST':
        # form = SignupForm(request.POST)
        # if form.is_valid():
            # username = request.POST.get('user')
        # email = form.cleaned_data.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        print(password)
        send_mail("OTP Verification ",f"Verify your mail by OTP :1234", EMAIL_HOST_USER, ['nemophile21@yahoo.com'], fail_silently=True)
        try:
                user = Users.objects.get(username=username)
        except Users.DoesNotExist:
                user = None
        if user and check_password(password, user.password):
        # if user and user.passw == password:
                request.session['username'] = username
                login(request,user)
                return redirect('userpage')
        # user = AuthenticatedForm(request.POST)
        # # user = authenticate(request,username=username,password=password)
        # print(user)
        # if user is not None:
        #     login(request,user)
        #     return redirect('userpage')
        else:
            messages.error(request,"Invalid Credentials")
    return render(request,'login.html')

def SignupView(request):
    # global counter
    # print(counter)
    if request.method == 'POST':
        # form = SignupForm(request.POST)
        # if form.is_valid():
            # username = request.POST.get('user')
        # email = form.cleaned_data.get('email')
        username = request.POST.get('username')
        password = request.POST.get('password')
        confirm_password = request.POST.get('pass1')
        email = request.POST.get('email')
        industry_name = request.POST.get('industry_name')
        mine_location = request.POST.get('mine_location')
        # otp = send_otp_email(request, email)
          # Store the OTP in session for verification
        if password != confirm_password:
            messages.error(request, "Passwords do not match")
        else:
            max_id = Users.objects.all().aggregate(Max('_id'))['_id__max']
            if max_id is None:
                max_id = 0 
            _id = max_id + 1
            otp = random.randint(100000, 999999)
            send_mail("OTP Verification ",f"Verify your mail by OTP : {otp} ", 'nemophile21@yahoo.com', [email], fail_silently=True)
            # user_data =
            # stored_otp = send_otp_email(request, email)
            
            print(password)
            # stored_otp = send_otp_email(request, email)
            # print(stored_otp)
            return render(request, 'verification.html', {'otp':otp,'_id': _id,'username':username,'email': email,'password':password,'industry_name':industry_name,'mine_location':mine_location})
            # stored_otp = send_otp_email(request, email)
            # return render(request,'verification.html',{'stored_otp':stored_otp})
            # return redirect('verification')
            # user_data.save()    # running this line after User.objects.create() gives error because it hashes the already hashed password again , updates previousone
            # return redirect('login')
    return render(request,'signup.html')

# # Verification view to handle OTP submission
# def VerificationView(request):
#     if request.method == 'POST':
#         email = request.POST.get('email')
#         otp_code = request.POST.get('otp')
#         # stored_otp = send_otp_email(request, email)
#         # stored_otp = request.POST.get('stored_otp')
#         # stored_otp = '123456'  # Replace this with the OTP retrieved from the database
        
#         # Compare otp_code with the generated OTP
#         if otp_code == stored_otp:
#             messages.success(request, "OTP Verified. Account created!")
#             return redirect('login')  # Redirect to login page after successful verification
#         else:
#             # If OTP does not match, show an error message or ask the user to retry
#             messages.error(request, "Invalid OTP. Please try again.")
#             return redirect('verification')  # Redirect back to OTP verification page
        
#     return render(request, 'verification.html')

def VerificationView(request):
    if request.method == 'POST':
        _id = request.POST.get('_id')
        email = request.POST.get('email')
        otp_code = request.POST.get('otp')
        # stored_otp = request.POST.get('stored_otp')
        username = request.POST.get('username')
        password = request.POST.get('password')
        email = request.POST.get('email')
        industry_name = request.POST.get('industry_name')
        mine_location = request.POST.get('mine_location')
        # if otp_code == stored_otp:
        #     messages.success(request, "OTP Verified. Account created!")
        Users.objects.create(
                    _id = _id,
                    username=username,
                    password=password,
                    email=email,
                    industry_name=industry_name,
                    mine_location=mine_location,
                    collection_name=username+"1"
                )
        return redirect('login')
    else:
            messages.error(request, "Invalid OTP. Please try again.")
            return redirect('verification')
    
    return render(request, 'verification.html')

def AboutView(request):
    return render(request,'about.html')

def ConveyorView(request):
    return render(request,'conveyor.html')

def ProfileView(request):
    return render(request,'profile.html')

def HomeView(request):
    return render(request,'home.html')

def RealtimeMaintenanceView(request):
    return render(request,'real_time_maintenance.html')

def CreateSystemView(request):
    if request.method=="POST":
         name = request.POST.get('name')
         totalPulleys = request.POST.get('totalPulleys')
         pulleysInShoe = request.POST.get('pulleysInShoe')
         beltLength = request.POST.get('beltLength')
         beltWidth = request.POST.get('beltWidth')
         beltThickness = request.POST.get('beltThickness')
         mine = request.POST.get('mine')
         industry = request.POST.get('industry')
        #  print(name,totalPulleys,pulleysInShoe,beltLength,beltWidth,beltThickness,mine,industry)
        #  smttg = Users.objects.get(username=request.session['username'])
        #  print(smttg._id) 
         user = Users.objects.get(username=request.session['username'])
         create_user_collection(request)
        #  Conveyors.create_collection(request,user)
         print(user)
        #  user._meta.db.create_collection(user.collection_name+"1")
         try:
            conveyor = Conveyors.objects.create(
                    userId=user,
                    name=name,
                    totalPulleys=totalPulleys,
                    pulleysInShoe=pulleysInShoe,
                    beltLength=beltLength,
                    beltWidth=beltWidth,
                    beltThickness=beltThickness,
                    mine=mine,
                    industry=industry,
            )
            conveyor.save()
            # if user.noConveyorSystem is None:
            #     user.noConveyorSystem = 0
            print(user.noConveyorSystem,user.noConveyorSystem+1)
            user.noConveyorSystem += 1
            user.save()
            # number_system = Users.objects.update(noConveyorSystem=user.noConveyorSystem+1)
            # number_system.save()
            print("success")
         except TypeError as e:
           print(f"System added: {e}")
        #    messages.error(request, "There was an error saving the conveyor. Please try again.")
           if user.noConveyorSystem is None:
                user.noConveyorSystem = 0
           user.noConveyorSystem += 1
           user.save()
        #         user.noConveyorSystem = 0
        #    print(user.noConveyorSystem,user.noConveyorSystem+1)
        #    number_system = Users.objects.update(noConveyorSystem=user.noConveyorSystem+1)
        #    number_system.save()
         
    return render(request,'create.html')

def SystemDetailsView(request):
    return render(request,'system_details.html')

def UserPageView(request):
    return render(request,'userpage.html')

def LogoutView(request):
    logout(request)
    return redirect('')